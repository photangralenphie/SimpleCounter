//
//  LeftCounterView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 07.01.23.
//

import SwiftUI

struct LeftCounterView: View {
    
    @Bindable public var counter: Counter
    
    var decreaseCounter: (Counter) -> Void
    var increaseCounter: (Counter) -> Void
    
    var body: some View {
        
        // Text view at beginning of counterView fixes the seperator not being full lenght
        Text("").padding(0)
        
        CounterButtonView(counter: counter, buttonAction: decreaseCounter.self, buttonType: .decrease)

        CounterDigitsView(counter: counter)
        
        CounterButtonView(counter: counter, buttonAction: increaseCounter.self, buttonType: .increase)
        
        Spacer()
        
        Text(counter.counterName)
    }
}
