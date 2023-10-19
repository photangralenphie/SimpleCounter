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
    
    @EnvironmentObject var stateVariables: StateVariables
    @EnvironmentObject private var settingsVariables: SettingsVariables

    let hapticFeedback = UIImpactFeedbackGenerator(style: .heavy)
    
    @State private var symbolAnimation: Bool = false
    @State private var confettiCannon: Int = 0
    
    var body: some View {
        VStack {
            Text("Congratulations!")
                .padding(.top)
            Text("You reached your goal.")
                .padding(.bottom)
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 200, height: 180)
                .scaledToFit()
                .foregroundColor(settingsVariables.accentColor==settingsVariables.componentsData.availibleColors.count ? .primary : Color(hex: settingsVariables.componentsData.availibleColors[settingsVariables.accentColor])) // SwiftUI does not respect tint so this is a workaround
                .symbolEffect(.bounce, value: symbolAnimation)
                .padding([.leading, .bottom, .trailing], 50)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(25)
        .onAppear(perform: congratulationsFeedback)
        .confettiCannon(counter: $confettiCannon, num: 25, openingAngle: Angle(degrees: 40), closingAngle: Angle(degrees: 140), repetitions: 8, repetitionInterval: 0.1)
    }
    
    func congratulationsFeedback() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            symbolAnimation.toggle()
        }
        confettiCannon += 1
        if settingsVariables.useSoundFeedback {
            Sound.play(file: "congratulations.mp3")
        }
        if settingsVariables.useHapticFeedback {
            hapticFeedback.impactOccurred()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation {
                stateVariables.showCongratulationsView = false
            }
        }
    }
}
