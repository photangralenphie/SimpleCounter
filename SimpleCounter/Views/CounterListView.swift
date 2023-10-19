//
//  CounterListView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 18.10.23
//

import SwiftUI
import SwiftData
import SwiftySound

struct CounterListView: View {
     
    @Environment(\.modelContext) private var modelContext
    @Query private var counters: [Counter]
    
    @EnvironmentObject private var stateVariables: StateVariables
    @EnvironmentObject private var settingsVariables: SettingsVariables
    
    @State private var showMultiAddAlert: Bool = false
    
    let hapticFeedback = UIImpactFeedbackGenerator(style: .medium)
    
    init(sort: SortDescriptor<Counter>) {
        _counters = Query(sort: [sort])
    }
    
    var body: some View {
        List {
            ForEach(counters) { counter in
                Section {
                    HStack(alignment: .center) {
                        switch settingsVariables.counterStyle {
                        case .left:
                            LeftCounterView(counter: counter,
                                              showMultiAddAlert: $showMultiAddAlert,
                                              decreaseCounter: self.decreaseCounter,
                                              increaseCounter: self.increaseCounter,
                                              decreaseCounterWithValue: self.decreaseCounterWithValue,
                                              increaseCouterWithValue: self.increaseCouterWithValue)
                        case .center:
                            CenterCounterView(counter: counter,
                                              showMultiAddAlert: $showMultiAddAlert, 
                                              decreaseCounter: self.decreaseCounter,
                                              increaseCounter: self.increaseCounter,
                                              decreaseCounterWithValue: self.decreaseCounterWithValue,
                                              increaseCouterWithValue: self.increaseCouterWithValue)
                        case .right:
                            Text("right style")
                            RightCounterView(counter: counter,
                                              showMultiAddAlert: $showMultiAddAlert,
                                              decreaseCounter: self.decreaseCounter,
                                              increaseCounter: self.increaseCounter,
                                              decreaseCounterWithValue: self.decreaseCounterWithValue,
                                              increaseCouterWithValue: self.increaseCouterWithValue)
                        case .system:
                            Text("system style")
                        }
                    }
                }
            }
            .onDelete { offsets in
                for index in offsets {
                    let counter = counters[index]
                    modelContext.delete(counter)
                }
                try? modelContext.save()
            }
        }
        .myListStyle(compactView: settingsVariables.compactView)
    }
    
    func increaseCounter(counter: Counter) {
        fireFeedback()
        counter.stepUp()
        try? modelContext.save()
        tryShowCongratulationsMessage(counter: counter)
    }
    
    func decreaseCounter(counter: Counter) {
        fireFeedback()
        counter.stepDown()
        try? modelContext.save()
    }
    
    func increaseCouterWithValue(counter: Counter, multiAddAmount: String) {
        counter._currentValue += Int64(multiAddAmount) ?? 0
        showMultiAddAlert = false
        tryShowCongratulationsMessage(counter: counter)
    }
    
    func decreaseCounterWithValue(counter: Counter, multiAddAmount: String) {
        counter._currentValue -= Int64(multiAddAmount) ?? 0
        showMultiAddAlert = false
    }
    
    func fireFeedback() {
        if settingsVariables.useHapticFeedback {
            hapticFeedback.impactOccurred()
        }
        if settingsVariables.useSoundFeedback {
            Sound.play(file: "button.mp3")
        }
    }
    
    func tryShowCongratulationsMessage(counter: Counter) {
        if (counter._valueGoal == counter._currentValue) {
            withAnimation {
                stateVariables.showCongratulationsView = true
            }
        }
    }
}