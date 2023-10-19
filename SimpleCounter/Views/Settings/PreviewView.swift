//
//  PreviewView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 18.10.23.
//

import SwiftUI

struct PreviewView: View {
    
    var counterStyle: CounterStyle
    
    var body: some View {
        Section(header: Text("Preview")) {
            switch counterStyle {
            case .left:
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
                
            case .center:
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
                
            case .right:
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
                
            case .system:
                Text("Coming Soon")
            }
        }
    }
}
