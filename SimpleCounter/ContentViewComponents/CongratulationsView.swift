//
//  CongratulationsView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 14.01.23.
//

import SwiftUI

struct CongratulationsView: View {
    
    @Binding public var showCongratulationsMessage: Bool
    
    var body: some View {
        VStack {
            Text("Congratulations!")
                .padding(.top)
            Text("You reached your target.")
                .padding(.bottom)
            Image(systemName: "checkmark")
                .resizable()
                .frame(width: 200, height: 200)
                .scaledToFit()
                .foregroundColor(.accentColor)
                .padding([.leading, .bottom, .trailing], 50)
        }
        .background(.ultraThinMaterial)
        .cornerRadius(25)
        .opacity(showCongratulationsMessage ? 1 : 0)
        .onChange(of: showCongratulationsMessage) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    showCongratulationsMessage = false
                }
            }
        }
    }
}
