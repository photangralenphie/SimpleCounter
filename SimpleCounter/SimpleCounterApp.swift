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
    
    let componentsData = MyComponentData()
    @AppStorage("accentColor") private var accentColor: Int = 0
    @StateObject private var stateVariables = StateVariables()
    @StateObject private var settingsVariables = SettingsVariables()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(stateVariables)
                .environmentObject(settingsVariables)
                .tint(accentColor==componentsData.availibleColors.count ? .primary : Color(hex: componentsData.availibleColors[accentColor]))
        }
        .modelContainer(for: Counter.self)
    }
}
