//
//  CounterListView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 07.01.23.
//

import SwiftUI
import CoreData

struct CounterListView: View {
    
    @FetchRequest var counters: FetchedResults<Counter>
    @Environment(\.managedObjectContext) var moc
    
    init(sortDescripter: NSSortDescriptor) {
            let request: NSFetchRequest<Counter> = Counter.fetchRequest()
            request.sortDescriptors = [sortDescripter]
            _counters = FetchRequest<Counter>(fetchRequest: request)
    }
    
    @AppStorage("counterStyle") private var counterStyle: Int = 1
    @AppStorage("compactView") private var compactView: Bool = false
    
    var body: some View {
        List {
            ForEach(counters, id: \.self) { counter in
                Section {
                    HStack(alignment: .center) {
                        switch counterStyle {
                        case 0:
                            LeftCounterView()
                        case 1:
                            CenterCounterView()
                        case 2:
                            RightCounterView()
                        default:
                             Text("Something went wrong")
                        }
                    }
                }
                .environmentObject(counter)
            }
            .onDelete { offsets in
                for index in offsets {
                    let counter = counters[index]
                    moc.delete(counter)
                }
                try? moc.save()
            }
        }
        .myListStyle(compactView: compactView)
    }
}

// ListStyle Extension
struct MyListViewModifier : ViewModifier {
    let compactView : Bool
    func body(content: Content) -> some View {
        if(compactView) {
            content.listStyle(.plain)
        } else {
            content.listStyle(.insetGrouped)
        }
    }
}

extension View {
    func myListStyle(compactView : Bool) -> some View {
        modifier(MyListViewModifier(compactView: compactView))
    }
}
