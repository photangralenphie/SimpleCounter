//
//  SimpleCounterApp.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 04.01.23.
//

import SwiftUI

@main
struct SimpleCounterApp: App {
    
    @StateObject private var dataController = DataController()
    @AppStorage("sortOption") private var sortOption: Int = 0
    
    let componentsData = MyComponentData()
    @AppStorage("accentColor") private var accentColor: Int = 0
    
    var body: some Scene {
    
        WindowGroup {
            switch sortOption {
            case 0:
                ContentView(sortDescriptor: NSSortDescriptor(key: "name", ascending: true))
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tint(Color(hex: componentsData.availibleColors[accentColor]))
            case 1:
                ContentView(sortDescriptor: NSSortDescriptor(key: "count", ascending: false))
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tint(Color(hex: componentsData.availibleColors[accentColor]))
            case 2:
                ContentView(sortDescriptor: NSSortDescriptor(key: "sortIDDate", ascending: false))
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tint(Color(hex: componentsData.availibleColors[accentColor]))
            case 3:
                ContentView(sortDescriptor: NSSortDescriptor(key: "sortIDUpdate", ascending: false))
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tint(Color(hex: componentsData.availibleColors[accentColor]))
            default:
                ContentView(sortDescriptor: NSSortDescriptor(key: "name", ascending: true))
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .tint(Color(hex: componentsData.availibleColors[accentColor]))
            }
        }
    }
}
