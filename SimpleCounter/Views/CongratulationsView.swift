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
    
    @Environment(StateVariables.self) var stateVariables
    @EnvironmentObject private var settingsVariables: SettingsVariables
    
    @State private var symbolAnimationTrigger: Bool = false
    @State private var confettiCannonTrigger: Int = 0
    @State private var hapticFeedbackTrigger: Bool = false
    
    var body: some View {
        VStack {
            Text("Congratulations!")
                .padding(.top)
            Text("You reached your goal.")
                .padding(.bottom)
            Image(systemName: "checkmark.seal")
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
                .foregroundColor(settingsVariables.getAccentColor())
                .symbolEffect(.bounce, value: symbolAnimationTrigger)
                .padding([.leading, .bottom, .trailing], 50)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(25)
        .onAppear(perform: congratulationsFeedback)
        .sensoryFeedback(.error, trigger: hapticFeedbackTrigger)
        .confettiCannon(counter: $confettiCannonTrigger,
                        num: 25,
                        openingAngle: Angle(degrees: 40),
                        closingAngle: Angle(degrees: 140),
                        repetitions: 8,
                        repetitionInterval: 0.1)
    }
    
    func congratulationsFeedback() {
        confettiCannonTrigger += 1
        
        if settingsVariables.useSoundFeedback {
            Sound.play(file: "congratulations.mp3")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            symbolAnimationTrigger.toggle()
            if settingsVariables.useHapticFeedback {
                hapticFeedbackTrigger.toggle()
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            withAnimation {
                stateVariables.showCongratulationsView = false
            }
        }
    }
}
