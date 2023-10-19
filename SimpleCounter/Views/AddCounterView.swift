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
    
    @State private var counterName: String = ""
    @State private var startValue: String = ""
    @State private var increment: String = ""
    @State private var valueGoal: String = ""

    @State private var noNameAlert: Bool = false
    
    @FocusState private var focusedField: Field?
    private enum Field {
        case name
        case goal
        case startValue
        case increment
    }
    
    var body: some View {
        NavigationView {
            Form {
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
                    HStack {
                        Image(systemName: "flag.checkered")
                            .foregroundColor(.accentColor)
                        Text("Goal: ")
                        TextField("", text: $valueGoal)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .goal)
                    }
                    
                    HStack {
                        Image(systemName: "number")
                            .foregroundColor(.accentColor)
                        
                        Text("Start Value: ")
                        TextField("0 (default)", text: $startValue)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .startValue)
                    }
                    
                    HStack {
                        Image(systemName: "arrow.up")
                            .foregroundColor(.accentColor)
                        Text("Increment: ")
                        TextField("1 (default)", text: $increment)
                            .keyboardType(.numberPad)
                            .focused($focusedField, equals: .increment)
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
                    }
                    .buttonStyle(.borderedProminent)
                }
                
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button(action: nextFocusField) {
                        Image(systemName: "chevron.down")
                    }
                    .disabled(focusedField == .increment)
                    Button(action: prevFocusField) {
                        Image(systemName: "chevron.up")
                    }
                    .disabled(focusedField == .name)
                }
            }
            .alert("Please provide a name for your counter", isPresented: $noNameAlert) {
                Button("OK", role: .cancel) {
                    focusedField = .name
                }
            }
        }
        .onAppear { focusedField = .name }
    }
    
    func nextFocusField() {
        switch focusedField {
            case .name:
                focusedField = .goal
            case .goal:
                focusedField = .startValue
            case .startValue:
                focusedField = .increment
            case .increment:
                focusedField = .name
            case nil:
                focusedField = .name
        }
    }
    
    func prevFocusField() {
        switch focusedField {
            case .name:
                focusedField = .increment
            case .goal:
                focusedField = .name
            case .startValue:
                focusedField = .goal
            case .increment:
                focusedField = .startValue
            case nil:
                focusedField = .name
        }
    }
    
    func addCounter() {
        if (counterName != "") {
            let newCounter = Counter(counterName: counterName,
                                     currentValue: Int64(startValue) ?? 0,
                                     increment: Int64(increment) ?? 1,
                                     hasGoal: valueGoal != "",
                                     valueGoal: Int64(valueGoal) ?? 0)
            modelContext.insert(newCounter)
            try? modelContext.save()
            
            dismiss()
        } else {
            noNameAlert.toggle()
        }
    }
}
