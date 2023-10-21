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
                Text(counter.counterName)
                Spacer()
                CounterDigitsView(counter: counter)
            }
        } onIncrement: {
            increaseCounter(counter)
        } onDecrement: {
            decreaseCounter(counter)
        }
    }
}
