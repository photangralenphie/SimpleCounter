//
//  NormalCounterView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 07.01.23.
//

import SwiftUI

struct CenterCounterView: View {

    @Bindable public var counter: Counter
    
    @Binding public var showMultiAddAlert: Bool
    @State private var multiAddAmount: String = ""
    
    var decreaseCounter: (Counter) -> Void
    var increaseCounter: (Counter) -> Void
    var decreaseCounterWithValue: (Counter, String) -> Void
    var increaseCouterWithValue: (Counter, String) -> Void
    
    var body: some View {
        // Text view at beginning and ending of counterView fixes the seperator not being full lenght
        Text("").padding(0)
        
        Image(systemName: "minus")
            .imageScale(.large)
            .foregroundColor(.accentColor)
            .padding()
            .onTapGesture { decreaseCounter(counter) }
            .onLongPressGesture { showMultiAddAlert.toggle() }
        
        Spacer()
        
        VStack(alignment: .center) {
            Text(counter._counterName)
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text("\(counter._currentValue)").font(.largeTitle)
                if (counter._hasGoal) {
                    Text("/\(counter._valueGoal)")
                }
            }
        }
        .alert("Add or subtract a big amount.", isPresented: $showMultiAddAlert) {
            TextField("Amount", text: $multiAddAmount)
                .keyboardType(.numberPad)
            Button("Plus") {
                increaseCouterWithValue(counter, multiAddAmount)
                multiAddAmount = ""
            }
            Button("Minus") {
                decreaseCounterWithValue(counter, multiAddAmount)
                multiAddAmount = ""
            }
            Button("Cancel", role: .cancel) { showMultiAddAlert = false }
        }
 
        Spacer()
        
        Image(systemName: "plus")
            .imageScale(.large)
            .foregroundColor(.accentColor)
            .padding()
            .onTapGesture { increaseCounter(counter) }
            .onLongPressGesture { showMultiAddAlert.toggle() }
        
        // Text view at beginning and ending of counterView fixes the seperator not being full lenght
        Text("").padding(0)
    }
}
