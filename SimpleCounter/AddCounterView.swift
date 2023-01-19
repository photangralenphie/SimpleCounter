//
//  AddCounterView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 07.01.23.
//

import SwiftUI

struct AddCounterView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @Environment(\.colorScheme) private var colorScheme
    
    @AppStorage("sortIDDate") private var sortIDDate: Int = 0
    @AppStorage("lastUpdateIndex") private var lastUpdateIndex: Int = 0
    
    @State private var isTargetCounter: Bool = false
    @State private var name: String = ""
    @State private var startValue: String = ""
    @State private var increment: String = ""
    @State private var target: String = ""

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
                Picker("Counter Typ", selection: $isTargetCounter.animation()) {
                    Text("Counter")
                        .tag(false)
                    Text("Target Counter")
                        .tag(true)
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                Form{
                    Section(header: Text("Name"), footer: Text("With a target counter you can set yourself a goal.")) {
                        HStack {
                            Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                .foregroundColor(.accentColor)
                            TextField("Name", text: $name)
                                .keyboardType(.alphabet)
                                .autocorrectionDisabled()
                                .focused($focusedField, equals: .name)
                        }

                        if (isTargetCounter) {
                            HStack {
                                Text("Target: ")
                                TextField("", text: $target)
                                    .keyboardType(.numberPad)
                            }
                        }
                    }

                    Section(header: Text("Optional")) {
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
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        if (name != "") {
                            let newCounter = Counter(context: moc)
                            newCounter.id = UUID()
                            newCounter.name = name
                            newCounter.count = Int64(startValue) ?? 0
                            newCounter.increaseCountBy = Int64(increment) ?? 1
                            newCounter.sortIDDate = Int64(sortIDDate)
                            newCounter.sortIDUpdate = Int64(lastUpdateIndex)
                            newCounter.hasTarget = isTargetCounter
                            if (isTargetCounter) {
                                newCounter.target = Int64(target) ?? 0
                            } else {
                                newCounter.target = 0
                            }
                            
                            // Updating for Sorting
                            sortIDDate+=1
                            lastUpdateIndex+=1
                            
                            try? moc.save()
                            
                            dismiss()
                        } else {
                            noNameAlert.toggle()
                        }
                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add")
                        }
                        .foregroundColor(colorScheme == .dark ? .black : .white)
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
}
