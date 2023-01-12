//
//  ProgressWidgetView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 12.01.23.
//

import SwiftUI

struct ProgressWidgetView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var counters: FetchedResults<Counter>
    let selectedCounter: String = "Books 2023"
    @State var widgetHasCounter: Bool = false
    var body: some View {
        
        ForEach(counters) { counter in
            if (counter.name == selectedCounter) {
                VStack(alignment: .center) {
                    Text(counter.name ?? "Unknown")
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("\(counter.count)")
                            .font(.largeTitle)
                        if (counter.hasTarget) {
                            Text("/\(counter.target)")
                        }
                    }
                }
                .onAppear {
                    widgetHasCounter=true
                }
            }
        }
        if !widgetHasCounter {
            Text("Please select counter in options")
                .padding()
        }
    }
}

