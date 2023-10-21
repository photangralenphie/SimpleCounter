//
//  SettingsVariables.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 19.10.23.
//

import Foundation
import SwiftUI

class SettingsVariables: ObservableObject {

    public let availibleColors = [Color.blue, Color.mint, Color.green, Color.yellow, Color.orange, Color.red, Color.pink, Color.purple, Color.brown, Color.primary]
    @AppStorage("accentColorIndex") public var accentColorIndex: Int = 0
    @AppStorage("counterStyle") public var counterStyle: CounterStyle = CounterStyle.center
    @AppStorage("compactView") public var compactView: Bool = false
    @AppStorage("moveControlsDown") public var moveControlsDown: Bool = false
    @AppStorage("useSoundFeedback") public var useSoundFeedback: Bool = true
    @AppStorage("useHapticFeedback") public var useHapticFeedback: Bool = true
    
    public func getAccentColor() -> Color {
        return availibleColors[accentColorIndex]
    }
}
