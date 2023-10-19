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
    
    //@AppStorage("useiCloudSync") private var useiCloudSync: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Accent Color")){
                    MyColorPicker(newColor: $settingsVariables.accentColor)
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
                    .toggleStyle(SwitchToggleStyle())
                    
                    Toggle(isOn: $settingsVariables.useHapticFeedback) {
                        Label("Haptic Feedback", systemImage: "iphone.gen1.radiowaves.left.and.right")
                    }
                    .toggleStyle(SwitchToggleStyle())
                    
                    /*
                    TODO for future
                    paid developer account needed for implementation. see here:
                    https://developer.apple.com/documentation/coredata/mirroring_a_core_data_store_with_cloudkit/setting_up_core_data_with_cloudkit
                    Toggle(isOn: $useiCloudSync, label: {
                        Label("iCloud Sync", systemImage: "icloud")
                    })
                    .toggleStyle(SwitchToggleStyle())
                     */
                }
                
                Section(header: Text("Credits")) {
                    NavigationLink("ConfettiSwiftUI") {
                        MITLicenceView(copyright: "2020 Simon Bachmann", name: "ConfettiSwiftUI")
                    }
                    NavigationLink("SwiftySound") {
                        MITLicenceView(copyright: "2017 Adam Cichy", name: "SwiftySound")
                    }
                }
            }
            .navigationTitle("Settings")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
        // This has to be here, otherwise colors won't visually! apply on change.
        //.tint(accentColor==componentsData.availibleColors.count ? .primary : Color(hex: componentsData.availibleColors[accentColor]))
    }
}
