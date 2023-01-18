//
//  SettingsView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 04.01.23.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("accentColor") private var accentColor: Int = 0
    @AppStorage("counterStyle") private var counterStyle: Int = 1
    @AppStorage("compactView") private var compactView: Bool = false
    @AppStorage("useSoundFeedback") private var useSoundFeedback: Bool = true
    @AppStorage("useHapticFeedback") private var useHapticFeedback: Bool = true
    
    @AppStorage("useiCloudSync") private var useiCloudSync: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Accent Color")){
                    MyColorPicker(newColor: $accentColor)
                }
                
                Section(header: Text("Counter Style")) {
                    Picker("Counter Style", selection: $counterStyle) {
                        Text("Left")
                            .tag(0)
                        Text("Center")
                            .tag(1)
                        Text("Right")
                            .tag(2)
                    }
                    .pickerStyle(.segmented)
                }
                
                Section(header: Text("Preview")) {
                    switch counterStyle {
                    case 0:
                        // Counter Version 0 (left)
                        HStack(alignment: .center) {
                            Image(systemName: "minus")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                            
                            Text("156")
                                .frame(minWidth: 70)
                                .font(.largeTitle)
                                .padding(.horizontal)
                            
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                            
                            Spacer()
                            
                            Text("Name")
                        }
                        
                    case 1:
                        // Counter Version 1 (center)
                        HStack(alignment: .center) {
                            Image(systemName: "minus")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                                .padding()
                            
                            Spacer()
                            
                            VStack(alignment: .center) {
                                Text("Name")
                                Text("156")
                                    .font(.largeTitle)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                                .padding()
                        }
                        
                    case 2:
                        // Counter Version 2 (right)
                        HStack(alignment: .center) {
                            Text("Name")
                            
                            Spacer()
                            
                            Image(systemName: "minus")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                            
                            Text("156")
                                .frame(minWidth: 70)
                                .font(.largeTitle)
                                .padding(.horizontal)
                            
                            Image(systemName: "plus")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                        }
                        
                    default:
                        Text("Something went wrong")
                    }
                }
                
                Section(header: Text("Other")) {
                    HStack {
                        Label("Layout: ", systemImage: "square.tophalf.filled")
                        Picker("Compact Counters", selection: $compactView) {
                            Text("Modern")
                                .tag(false)
                            Text("Compact")
                                .tag(true)
                        }
                        .pickerStyle(.segmented)
                    }

                    Toggle(isOn: $useSoundFeedback, label: {
                        Label("Sounds", systemImage: useSoundFeedback ? "speaker.wave.2.fill" : "speaker.slash.fill")
                    })
                    .toggleStyle(SwitchToggleStyle())
                    
                    Toggle(isOn: $useHapticFeedback, label: {
                        Label("Haptic Feedback", systemImage: "iphone.gen1.radiowaves.left.and.right")
                    })
                    .toggleStyle(SwitchToggleStyle())
                    
                    /*
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
    }
}
