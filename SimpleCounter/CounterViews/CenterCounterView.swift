//
//  NormalCounterView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 07.01.23.
//

import SwiftUI

struct CenterCounterView: View {
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var counter: Counter
    
    @AppStorage("useHapticFeedback") private var useHapticFeedback: Bool = true
    let hapticFeedback = UIImpactFeedbackGenerator(style: .medium)
    @AppStorage("lastUpdateIndex") private var lastUpdateIndex: Int = 0
    
    var body: some View {
        // Text view at beginning and ending of counterView fixes the seperator not being full lenght
        Text("")
            .padding(0)
        
        Image(systemName: "minus")
            .imageScale(.large)
            .foregroundColor(.accentColor)
            .padding()
            .onTapGesture {
                hapticFeedback.impactOccurred()
                counter.count-=counter.increaseCountBy
                counter.sortIDUpdate = Int64(lastUpdateIndex)
                lastUpdateIndex+=1
                try? moc.save()
            }
        
        Spacer()
        
        VStack(alignment: .center) {
            Text(counter.name ?? "Unknown")
            Text("\(counter.count)")
                .font(.largeTitle)
        }
        
        Spacer()
        
        Image(systemName: "plus")
            .imageScale(.large)
            .foregroundColor(.accentColor)
            .padding()
            .onTapGesture {
                hapticFeedback.impactOccurred()
                counter.count+=counter.increaseCountBy
                counter.sortIDUpdate = Int64(lastUpdateIndex)
                lastUpdateIndex+=1
                try? moc.save()
            }
        
        Text("")
            .padding(0)
    }
}
