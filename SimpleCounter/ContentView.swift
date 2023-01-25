//
//  ContentView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 04.01.23.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State var sortDescriptor: NSSortDescriptor
    @AppStorage("sortOption") private var sortOption: Int = 0
    
    @State private var showSettings: Bool = false
    @State private var addCounter: Bool = false
    
    @AppStorage("sortIDDate") private var sortIDDate: Int = 0
    
    @State private var showCongratulationsMessage: Bool = false
        
    var body: some View {
        ZStack {
            NavigationStack {
                ZStack {
                    CounterListView(sortDescripter: sortDescriptor, showCongratulationsMessage: $showCongratulationsMessage)
                    
                    HStack {
                        Spacer()
                        VStack (alignment: .center) {
                            Spacer()
                            Button {
                                addCounter.toggle()
                                try? moc.save()
                            } label: {
                                Image(systemName: "plus")
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(25)
                                    .overlay( // for rounded border
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(Color.accentColor, lineWidth: 1)
                                    )
                                    .shadow(radius: 7)
                            }
                            .padding()
                        }
                    }
                }
                .navigationTitle("Counters")
                .sheet(isPresented: $showSettings) {
                    SettingsView()
                }
                .sheet(isPresented: $addCounter) {
                    AddCounterView()
                        .environment(\.managedObjectContext, moc)
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            showSettings.toggle()
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Menu {
                            Label("Sorting Options", systemImage: "arrow.up.arrow.down")
                            Divider()
                            Button {
                                sortOption = 0
                                sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
                            } label: {
                                Label("Aphabetical", systemImage: sortOption==0 ? "checkmark" : "")
                            }
                            Button {
                                sortOption = 1
                                sortDescriptor = NSSortDescriptor(key: "count", ascending: false)
                            } label: {
                                Label("Count", systemImage: sortOption==1 ? "checkmark" : "")
                            }
                            Button {
                                sortOption = 2
                                sortDescriptor = NSSortDescriptor(key: "sortIDDate", ascending: false)
                            } label: {
                                Label("Newest", systemImage: sortOption==2 ? "checkmark" : "")
                            }
                            Button {
                                sortOption = 3
                                sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
                            } label: {
                                Label("Last update", systemImage: sortOption==3 ? "checkmark" : "")
                            }
                        } label: {
                            Image(systemName: "arrow.up.arrow.down")
                        }
                    }
                }
            }
        
            CongratulationsView(showCongratulationsMessage: $showCongratulationsMessage)
        }
    }
}
