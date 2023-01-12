//
//  LeftCounterView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 07.01.23.
//

import SwiftUI

struct LeftCounterView: View {
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var counter: Counter
    
    @AppStorage("useHapticFeedback") private var useHapticFeedback: Bool = true
    let hapticFeedback = UIImpactFeedbackGenerator(style: .medium)
    @AppStorage("lastUpdateIndex") private var lastUpdateIndex: Int = 0
    
    var body: some View {
        
        // Text view at beginning of counterView fixes the seperator not being full lenght
        Text("")
            .padding(0)
        
        Image(systemName: "minus")
            .imageScale(.large)
            .foregroundColor(.accentColor)
            .onTapGesture {
                hapticFeedback.impactOccurred()
                counter.count-=counter.increaseCountBy
                counter.sortIDUpdate = Int64(lastUpdateIndex)
                lastUpdateIndex+=1
                try? moc.save()
            }
        
        Text("\(counter.count)")
            .frame(minWidth: 70)
            .font(.largeTitle)
            .padding(.horizontal)
        
        Image(systemName: "plus")
            .imageScale(.large)
            .foregroundColor(.accentColor)
            .onTapGesture {
                hapticFeedback.impactOccurred()
                counter.count+=counter.increaseCountBy
                counter.sortIDUpdate = Int64(lastUpdateIndex)
                lastUpdateIndex+=1
                try? moc.save()
            }
        
        Spacer()
        
        Text(counter.name ?? "Unknown")
    }
}
