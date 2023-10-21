//
//  RightCounterView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 07.01.23.
//

import SwiftUI

struct RightCounterView: View {
    
    @Bindable public var counter: Counter
    
    var decreaseCounter: (Counter) -> Void
    var increaseCounter: (Counter) -> Void
    
    var body: some View {
        Text(counter.counterName)
        
        Spacer()
        
        CounterButtonView(counter: counter, buttonAction: decreaseCounter.self, buttonType: .decrease)
        
        CounterDigitsView(counter: counter)
        
        CounterButtonView(counter: counter, buttonAction: increaseCounter.self, buttonType: .increase)
    }
}
