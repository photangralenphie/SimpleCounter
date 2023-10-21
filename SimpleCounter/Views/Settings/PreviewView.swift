//
//  PreviewView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 18.10.23.
//

import SwiftUI

struct PreviewView: View {
    
    var counterStyle: CounterStyle
    @State private var count: Int = 156
    
    var body: some View {
        Section(header: Text("Preview")) {
            switch counterStyle {
            case .left:
                HStack(alignment: .center) {
                    Image(systemName: "minus")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .onTapGesture { count -= 1 }
                    
                    Text("\(count)")
                        .frame(minWidth: 70)
                        .font(.largeTitle)
                        .padding(.horizontal)
                    
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .onTapGesture { count += 1 }
                    
                    Spacer()
                    
                    Text("Name")
                }
                
            case .center:
                HStack(alignment: .center) {
                    Image(systemName: "minus")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .padding()
                        .onTapGesture { count -= 1 }
                    
                    Spacer()
                    
                    VStack(alignment: .center) {
                        Text("Name")
                        Text("\(count)").font(.largeTitle)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .padding()
                        .onTapGesture { count += 1 }
                }
                
            case .right:
                HStack(alignment: .center) {
                    Text("Name")
                    
                    Spacer()
                    
                    Image(systemName: "minus")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .onTapGesture { count -= 1 }
                    
                    Text("\(count)")
                        .frame(minWidth: 70)
                        .font(.largeTitle)
                        .padding(.horizontal)
                    
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .onTapGesture { count += 1 }
                }
                
            case .system:
                Stepper(value: $count) {
                    HStack {
                        Text("Name")
                        Spacer()
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Text("\(count)").font(.largeTitle)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}
