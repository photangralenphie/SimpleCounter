//
//  MITLicenceView.swift
//  SimpleCounter
//
//  Created by Jonas Helmer on 18.01.23.
//

import SwiftUI

struct MITLicence: View {
    
    var copyright: String
    var name: String
    
    var body: some View {
        NavigationLink("\(name)") {
            Form {
                Text("MIT License")
                Text("Copyright (c) \(copyright)")
                Text("Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the right to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:")
                Text("The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.")
                Text("THE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.")
            }
            .navigationTitle("\(name)")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
