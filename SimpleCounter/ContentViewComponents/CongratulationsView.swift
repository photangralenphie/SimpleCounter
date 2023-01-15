//
//  CongratulationsView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 14.01.23.
//

import SwiftUI
import SwiftySound

struct CongratulationsView: View {
    
    @Binding public var showCongratulationsMessage: Bool
    
    @AppStorage("useSoundFeedback") private var useSoundFeedback: Bool = true
    @AppStorage("useHapticFeedback") private var useHapticFeedback: Bool = true
    let hapticFeedback = UIImpactFeedbackGenerator(style: .heavy)
    
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
                .foregroundColor(.accentColor)
                .padding([.leading, .bottom, .trailing], 50)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(25)
        .opacity(showCongratulationsMessage ? 1 : 0)
        .onChange(of: showCongratulationsMessage) { _ in
            if showCongratulationsMessage {
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
    }
}
