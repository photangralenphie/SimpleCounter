//
//  ListStyleModifier.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 18.10.23.
//

import Foundation
import SwiftUI

// ListStyle Extension
struct MyListViewModifier : ViewModifier {
    let compactView : Bool
    func body(content: Content) -> some View {
        if(compactView) {
            content.listStyle(.plain)
        } else {
            content.listStyle(.insetGrouped)
        }
    }
}

extension View {
    func myListStyle(compactView : Bool) -> some View {
        modifier(MyListViewModifier(compactView: compactView))
    }
}
