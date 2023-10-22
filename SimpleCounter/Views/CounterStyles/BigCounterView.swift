//
//  BigCounterView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 22.10.23.
//

import SwiftUI

struct BigCounterView: View {
    
    @Bindable public var counter: Counter
    
    var decreaseCounter: (Counter) -> Void
    var increaseCounter: (Counter) -> Void
    
    @EnvironmentObject private var settingsVariables: SettingsVariables
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                HStack(alignment: .firstTextBaseline) {
                    Text("\(counter.currentValue)")
                        .font(.system(size: 150))
                    if counter.hasGoal {
                        Text("of \(counter.valueGoal)")
                            .font(.largeTitle)
                    }
                }
                
                Spacer()

                HStack {
                    BigCounterButtonView(counter: counter, buttonIcon: "minus", buttonAction: self.decreaseCounter)
                    BigCounterButtonView(counter: counter, buttonIcon: "plus", buttonAction: self.increaseCounter)
                }
            }
            .navigationTitle(counter.counterName)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Close", systemImage: "xmark.circle")
                            .scaleEffect(2)
                            .labelStyle(.iconOnly)
                    }
                }
            }
        }
    }
}

struct BigCounterButtonView: View {
    
    @Bindable public var counter: Counter
    var buttonIcon: String
    var buttonAction: (Counter) -> Void
    
    @EnvironmentObject private var settingsVariables: SettingsVariables
    
    var body: some View {
        Button {
            buttonAction(counter)
        } label: {
            RoundedRectangle(cornerRadius: 25)
                .frame(minWidth: 100, maxHeight: 400)
                .foregroundColor(settingsVariables.getAccentColor())
                .overlay {
                    Image(systemName: buttonIcon)
                        .font(.largeTitle)
                        .imageScale(.large)
                        .foregroundColor(.primary)
                }
        }
        .buttonRepeatBehavior(.enabled)
    }
}
