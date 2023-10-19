//
//  SettingsVariables.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 19.10.23.
//

import Foundation
import SwiftUI

class SettingsVariables: ObservableObject {
    let componentsData = MyComponentData()
    @AppStorage("accentColor") public var accentColor: Int = 0
    @AppStorage("counterStyle") public var counterStyle: CounterStyle = CounterStyle.center
    @AppStorage("compactView") public var compactView: Bool = false
    @AppStorage("moveControlsDown") public var moveControlsDown: Bool = false
    @AppStorage("useSoundFeedback") public var useSoundFeedback: Bool = true
    @AppStorage("useHapticFeedback") public var useHapticFeedback: Bool = true
}
