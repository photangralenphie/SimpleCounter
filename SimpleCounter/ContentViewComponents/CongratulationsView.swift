//
//  CongratulationsView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 14.01.23.
//

import SwiftUI
import SwiftySound
import ConfettiSwiftUI

struct CongratulationsView: View {
    
    @Binding public var showCongratulationsMessage: Bool
    
    let componentsData = MyComponentData()
    @AppStorage("accentColor") private var accentColor: Int = 0
    
    @AppStorage("useSoundFeedback") private var useSoundFeedback: Bool = true
    @AppStorage("useHapticFeedback") private var useHapticFeedback: Bool = true
    let hapticFeedback = UIImpactFeedbackGenerator(style: .heavy)
    
    @State private var confettiCannon: Int = 0
    
    var body: some View {
        VStack {
            Text("Congratulations!")
                .padding(.top)
            Text("You reached your target.")
                .padding(.bottom)
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 200, height: 180)
                .scaledToFit()
                .foregroundColor(accentColor==componentsData.availibleColors.count ? .primary : Color(hex: componentsData.availibleColors[accentColor])) // SwiftUI does not respect tint so this is a workaround
                .padding([.leading, .bottom, .trailing], 50)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(25)
        .opacity(showCongratulationsMessage ? 1 : 0)
        .onChange(of: showCongratulationsMessage) { _ in
            if showCongratulationsMessage {
                confettiCannon += 1
                if useSoundFeedback {
                    Sound.play(file: "congratulations.mp3")
                }
                if useHapticFeedback {
                    hapticFeedback.impactOccurred()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    withAnimation {
                        showCongratulationsMessage = false
                    }
                }
            }
        }
        .confettiCannon(counter: $confettiCannon, num: 25, openingAngle: Angle(degrees: 40), closingAngle: Angle(degrees: 140), repetitions: 8, repetitionInterval: 0.1)
    }
}
