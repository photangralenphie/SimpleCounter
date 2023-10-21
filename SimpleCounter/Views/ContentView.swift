//
//  ContentView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 18.10.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Query private var counters: [Counter]
    
    @State private var showSettings: Bool = false
    @State private var showAddSheet: Bool = false
    
    @State private var sortDescriptor = SortDescriptor(\Counter.counterName, order: .forward)
    @State private var sortOrder: SortOrder = .forward
    
    @Environment(StateVariables.self) private var stateVariables
    @EnvironmentObject private var settingsVariables: SettingsVariables
    
    var body: some View {
        NavigationStack {
            CounterListView(sort: sortDescriptor)
            .toolbar {
                ToolbarItem(placement: settingsVariables.moveControlsDown ? .status : .topBarLeading) {
                    Button {
                        showSettings.toggle()
                    } label: {
                        Label("Settings", systemImage: "gear")
                    }
                }
                
                ToolbarItem(placement: settingsVariables.moveControlsDown ? .status : .topBarTrailing) {
                    Menu {
                        Section {
                            Picker("Sort", selection: $sortDescriptor.animation()) {
                                Label("Alphabetical", systemImage: "character")
                                    .tag(SortDescriptor(\Counter.counterName, order: sortOrder))
                                Label("Count", systemImage: "number")
                                    .tag(SortDescriptor(\Counter.currentValue, order: sortOrder))
                                Label("Creation Date", systemImage: "calendar")
                                    .tag(SortDescriptor(\Counter.creationDate, order: sortOrder))
                                Label("Last Update", systemImage: "pencil")
                                    .tag(SortDescriptor(\Counter.updateDate, order: sortOrder))
                            }
                            Picker("Order", selection: $sortOrder.animation()) {
                                Label("Acending", systemImage: "arrow.up")
                                    .tag(SortOrder.forward)
                                Label("Decending", systemImage: "arrow.down")
                                    .tag(SortOrder.reverse)
                            }
                        } header: {
                            Label("Sorting by:", systemImage: "arrow.up.arrow.down")
                        }
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
                
                ToolbarItem(placement: settingsVariables.moveControlsDown ? .status : .topBarTrailing) {
                    Button {
                        showAddSheet.toggle()
                    } label: {
                        Label("Add Counter", systemImage: "plus")
                    }
                }
            }
            .navigationTitle("Counter")
            .popover(isPresented: $showAddSheet) { AddCounterView() }
            .sheet(isPresented: $showSettings) { SettingsView() }
            .overlay(content: {
                if counters.isEmpty {
                    NoCounterView(showAddSheet: $showAddSheet)
                } else if stateVariables.showCongratulationsView {
                    CongratulationsView()
                }
            })
        }
    }
}
