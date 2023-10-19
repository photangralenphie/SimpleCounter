//
//  AddCounterView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 18.10.23.
//

import SwiftUI

struct AddCounterView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var modelContext
    
    @State private var hasGoal: Bool = false
    @State private var counterName: String = ""
    @State private var startValue: String = ""
    @State private var increment: String = ""
    @State private var valueGoal: String = ""

    @State private var noNameAlert: Bool = false
    
    // TO BE IMPLEMENTED FURTHER
    @FocusState private var focusedField: Field?
    private enum Field: Int, CaseIterable {
        case name
        case target
        case value
        case increment
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Form{
                    Section(header: Text("Name"), footer: Text("With a target counter you can set yourself a goal.")) {
                        HStack {
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                .foregroundColor(.accentColor)
                            TextField("Name", text: $counterName)
                                .keyboardType(.alphabet)
                                .autocorrectionDisabled()
                                .focused($focusedField, equals: .name)
                        }
                    }

                    Section(header: Text("Optional")) {
                        Toggle(isOn: $hasGoal.animation()) {
                            Text("Has goal?")
                        }
                        
                        if hasGoal {
                            HStack {
                                Image(systemName: "flag.checkered")
                                    .foregroundColor(.accentColor)
                                Text("Goal: ")
                                TextField("", text: $valueGoal)
                                    .keyboardType(.numberPad)
                            }
                        }

                        HStack {
                            Image(systemName: "number")
                                .foregroundColor(.accentColor)
                            
                            Text("Start Value: ")
                            TextField("0 (default)", text: $startValue)
                                .keyboardType(.numberPad)
                        }
                        
                        HStack {
                            Image(systemName: "arrow.up")
                                .foregroundColor(.accentColor)
                            Text("Increment: ")
                            TextField("1 (default)", text: $increment)
                                .keyboardType(.numberPad)
                        }
                    }
                }
            }
            .navigationTitle("New Counter")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: addCounter) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add")
                        }
                        //.foregroundColor(colorScheme == .dark ? .black : .white)
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .alert("Please provide a name for your counter", isPresented: $noNameAlert) {
                Button("OK", role: .cancel) {
                    focusedField = .name
                }
            }
        }
        .onAppear {
            focusedField = .name
        }
    }
    
    func addCounter() {
        if (counterName != "") {
            let newCounter = Counter(counterName: counterName,
                                     currentValue: Int64(startValue) ?? 0,
                                     increment: Int64(increment) ?? 1,
                                     hasGoal: hasGoal,
                                     valueGoal: Int64(valueGoal) ?? 0)
            modelContext.insert(newCounter)
            try? modelContext.save()
            
            dismiss()
        } else {
            noNameAlert.toggle()
        }
    }
}
