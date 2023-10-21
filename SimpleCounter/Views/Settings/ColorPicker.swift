//
//  ColorPicker.swift
//  EasyChecklist
//
//  Created by Jonas Helmer on 11.10.22.
//

import SwiftUI

struct ColorPicker: View {
    
    @EnvironmentObject private var settingsVariables: SettingsVariables
    
    var body: some View {
        HStack {
            // All normal colors
            ForEach(0..<settingsVariables.availibleColors.count - 1, id: \.self) { colorIndex in
                Circle()
                    .strokeBorder(colorIndex == settingsVariables.accentColorIndex ? Color.primary : Color.clear , lineWidth: 3)
                    .background(Circle().foregroundColor(settingsVariables.availibleColors[colorIndex]))
                    .padding(.horizontal, -13)
                    .onTapGesture { settingsVariables.accentColorIndex = colorIndex }
            }
            
            // Primary Color
            Circle()
                .strokeBorder(settingsVariables.availibleColors.count == settingsVariables.accentColorIndex + 1 ? Color.primary : Color.clear, lineWidth: 3)
                .background{
                    Image(systemName: "circle.righthalf.fill")
                        .imageScale(.large)
                }
                .padding(.horizontal, -13)
                .onTapGesture { settingsVariables.accentColorIndex = settingsVariables.availibleColors.count - 1 }
        }
        .padding(.vertical)
    }
}
