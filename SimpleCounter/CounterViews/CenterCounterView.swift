//
//  NormalCounterView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 07.01.23.
//

import SwiftUI
import SwiftySound

struct CenterCounterView: View {
    
    @Binding public var showCongratulationsMessage: Bool
    
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var counter: Counter
    
    @AppStorage("useSoundFeedback") private var useSoundFeedback: Bool = true
    @AppStorage("useHapticFeedback") private var useHapticFeedback: Bool = true
    let hapticFeedback = UIImpactFeedbackGenerator(style: .medium)
    @AppStorage("lastUpdateIndex") private var lastUpdateIndex: Int = 0
    
    @State private var showMultiAddAlert: Bool = false
    @State private var multiAddAmount: String = ""
    
    var body: some View {
        // Text view at beginning and ending of counterView fixes the seperator not being full lenght
        Text("")
            .padding(0)
        
        Image(systemName: "minus")
            .imageScale(.large)
            .foregroundColor(.accentColor)
            .padding()
            //.gesture(longPress)
            .onTapGesture {
                if useHapticFeedback {
                    hapticFeedback.impactOccurred()
                }
                if useSoundFeedback {
                    Sound.play(file: "button.mp3")
                }
                counter.count-=counter.increaseCountBy
                counter.sortIDUpdate = Int64(lastUpdateIndex)
                lastUpdateIndex+=1
                try? moc.save()
            }
            .onLongPressGesture {
                showMultiAddAlert.toggle()
            }
        
        Spacer()
        
        VStack(alignment: .center) {
            Text(counter.name ?? "Unknown")
            HStack(alignment: .firstTextBaseline, spacing: 0) {
                Text("\(counter.count)")
                    .font(.largeTitle)
                if (counter.hasTarget) {
                    Text("/\(counter.target)")
                }
            }
        }
        .alert("Add or subtract a big amount.", isPresented: $showMultiAddAlert) {
            TextField("Amount", text: $multiAddAmount)
                .keyboardType(.numberPad)
            Button("Plus") {
                counter.count+=Int64(multiAddAmount) ?? 0
                showMultiAddAlert = false
                if (counter.target <= counter.count) {
                    withAnimation {
                        showCongratulationsMessage = true
                    }
                }
            }
            Button("Minus") {
                counter.count-=Int64(multiAddAmount) ?? 0
                showMultiAddAlert = false
            }
            Button("Cancel", role: .cancel, action: {
                showMultiAddAlert = false
            })
        }
 
        Spacer()
        
        Image(systemName: "plus")
            .imageScale(.large)
            .foregroundColor(.accentColor)
            .padding()
            .onTapGesture {
                if useHapticFeedback {
                    hapticFeedback.impactOccurred()
                }
                if useSoundFeedback {
                    Sound.play(file: "button.mp3")
                }
                counter.count+=counter.increaseCountBy
                counter.sortIDUpdate = Int64(lastUpdateIndex)
                lastUpdateIndex+=1
                try? moc.save()
                if (counter.target == counter.count) {
                    withAnimation {
                        showCongratulationsMessage = true
                    }
                }
            }
            .onLongPressGesture {
                showMultiAddAlert.toggle()
            }
        
        Text("")
            .padding(0)
    }
}
