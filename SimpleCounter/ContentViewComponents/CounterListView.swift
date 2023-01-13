//
//  CounterListView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 07.01.23.
//

import SwiftUI
import CoreData

struct CounterListView: View {
    
    @Binding public var showCongratulationsMessage: Bool
    
    @FetchRequest var counters: FetchedResults<Counter>
    @Environment(\.managedObjectContext) var moc
    
    init(sortDescripter: NSSortDescriptor, showCongratulationsMessage: Binding<Bool>) {
        _showCongratulationsMessage = showCongratulationsMessage
    
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
                            LeftCounterView(showCongratulationsMessage: $showCongratulationsMessage)
                        case 1:
                            CenterCounterView(showCongratulationsMessage: $showCongratulationsMessage)
                        case 2:
                            RightCounterView(showCongratulationsMessage: $showCongratulationsMessage)
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
