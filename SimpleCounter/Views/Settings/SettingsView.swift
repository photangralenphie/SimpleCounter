//
//  SettingsView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 04.01.23.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var settingsVariables: SettingsVariables
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Accent Color")){
                    ColorPicker()
                }
                
                Section(header: Text("Counter Style")) {
                    Picker("Counter Style", selection: $settingsVariables.counterStyle) {
                        Text("Left")
                            .tag(CounterStyle.left)
                        Text("Center")
                            .tag(CounterStyle.center)
                        Text("Right")
                            .tag(CounterStyle.right)
                        Text("System")
                            .tag(CounterStyle.system)
                    }
                    .pickerStyle(.segmented)
                    
                    HStack {
                        Label("Layout: ", systemImage: "square.tophalf.filled")
                        Picker("Compact Counters", selection: $settingsVariables.compactView) {
                            Text("Modern")
                                .tag(false)
                            Text("Compact")
                                .tag(true)
                        }
                        .pickerStyle(.segmented)
                    }
                }
                
                PreviewView(counterStyle: settingsVariables.counterStyle)
                
                Section(header: Text("Other")) {
                    Toggle(isOn: $settingsVariables.moveControlsDown) {
                        Label("Move controls down", systemImage: "platter.filled.bottom.and.arrow.down.iphone")
                    }

                    Toggle(isOn: $settingsVariables.useSoundFeedback) {
                        Label("Sounds", systemImage: settingsVariables.useSoundFeedback ? "speaker.wave.2.fill" : "speaker.slash.fill")
                    }
                    
                    Toggle(isOn: $settingsVariables.useHapticFeedback) {
                        Label("Haptic Feedback", systemImage: "iphone.gen1.radiowaves.left.and.right")
                    }
                    
                    Button(action: openSettings) {
                        Label("Language (opens Settings App)", systemImage: "globe")
                    }
                }
                
                Section(header: Text("Credits")) {
                    MITLicence(copyright: "2020 Simon Bachmann", name: "ConfettiSwiftUI")
                    MITLicence(copyright: "2017 Adam Cichy", name: "SwiftySound")
                }
            }
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url)
        }
    }
}
