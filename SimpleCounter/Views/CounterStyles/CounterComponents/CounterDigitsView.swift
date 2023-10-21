//
//  CounterDigitsView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 21.10.23.
//

import SwiftUI

struct CounterDigitsView: View {
    
    @Bindable public var counter: Counter
    
    @State private var showCounterAdjustAleart: Bool = false
    @State private var newCounterAmount: Int64 = 0
    
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 0) {
            Text("\(counter.currentValue)").font(.largeTitle)
            if (counter.hasGoal) {
                Text("/\(counter.valueGoal)")
            }
        }
        .frame(minWidth: 90)
        .onLongPressGesture {
            showCounterAdjustAleart.toggle()
            newCounterAmount = counter.currentValue
        }
        .alert("Adjust counter value.", isPresented: $showCounterAdjustAleart) {
            TextField("Value", value: $newCounterAmount, formatter: NumberFormatter())
                .keyboardType(.numberPad)
            Button("OK") { counter.currentValue = newCounterAmount }
            Button("Cancel", role: .cancel) { showCounterAdjustAleart = false }
        }
    }
}
