//
//  NoCounterViews.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 19.10.23.
//

import SwiftUI

struct NoCounterView: View {
    
    @Binding public var showAddSheet: Bool
    
    var body: some View {
        ContentUnavailableView {
            Image(systemName: "plus")
                .font(.largeTitle)
                .bold()
                .padding(.bottom)
            Text("No counter availible")
        } description: {
            Text("Get started by adding a counter with the button below or the plus icon in the toolbar.")
        } actions: {
            Button {
                showAddSheet.toggle()
            } label: {
                Label("Add Counter", systemImage: "plus")
            }
            .buttonStyle(.borderedProminent)
        }
    }
}
