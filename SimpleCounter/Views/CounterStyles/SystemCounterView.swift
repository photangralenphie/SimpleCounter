//
//  SystemCounterView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 19.10.23.
//

import SwiftUI

struct SystemCounterView: View {
    
    @Bindable public var counter: Counter
    
    var decreaseCounter: (Counter) -> Void
    var increaseCounter: (Counter) -> Void
    
    var body: some View {
        Stepper {
            HStack {
                Text(counter._counterName)
                Spacer()
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("\(counter._currentValue)").font(.largeTitle)
                    if (counter._hasGoal) {
                        Text("/\(counter._valueGoal)")
                    }
                }
            }
            .padding(.horizontal)
        } onIncrement: {
            increaseCounter(counter)
        } onDecrement: {
            decreaseCounter(counter)
        }
    }
}
