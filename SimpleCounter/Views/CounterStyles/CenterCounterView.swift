//
//  NormalCounterView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 07.01.23.
//

import SwiftUI

struct CenterCounterView: View {

    @Bindable public var counter: Counter
    
    var decreaseCounter: (Counter) -> Void
    var increaseCounter: (Counter) -> Void
    
    var body: some View {
        // Text view at beginning and ending of counterView fixes the seperator not being full lenght
        Text("").padding(0)
        
        CounterButtonView(counter: counter, buttonAction: decreaseCounter.self, buttonType: .decrease)
        
        Spacer()
        
        VStack(alignment: .center) {
            Text(counter.counterName)
            CounterDigitsView(counter: counter)
        }
 
        Spacer()
        
        CounterButtonView(counter: counter, buttonAction: increaseCounter.self, buttonType: .increase)

        // Text view at beginning and ending of counterView fixes the seperator not being full lenght
        Text("").padding(0)
    }
}
