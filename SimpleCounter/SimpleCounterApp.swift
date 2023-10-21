//
//  SimpleCounterApp.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 18.10.23.
//

import SwiftUI
import SwiftData

@main
struct SimpleCounterApp: App {
    
    private var stateVariables = StateVariables()
    @StateObject private var settingsVariables = SettingsVariables()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(stateVariables)
                .environmentObject(settingsVariables)
                .tint(settingsVariables.getAccentColor())
        }
        .modelContainer(for: Counter.self)
    }
}
