//
//  CounterButtonView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 21.10.23.
//

import SwiftUI

struct CounterButtonView: View {
    
    @Bindable public var counter: Counter
    var buttonAction: (Counter) -> Void
    var buttonType: CounterButtonType
    
    var body: some View {
        Button {
            buttonAction(counter)
        } label: {
            Image(systemName: getButtonType())
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .padding()
        }
        .buttonStyle(BorderlessButtonStyle())
        .buttonRepeatBehavior(.enabled)
    }
    
    fileprivate func getButtonType() -> String {
        switch buttonType {
            case .decrease:
                return "minus"
            case .increase:
                return "plus"
        }
    }
}
