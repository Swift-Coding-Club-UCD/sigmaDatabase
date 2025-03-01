//
//  ContentView.swift
//  sigmaDatabase
//
//  Created by Mark Le on 2/26/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello World")
                    .font(.title)
                    .padding()
                
                // Add your login form here
            }
            .navigationTitle("Firebase Auth")
        }
    }
}


#Preview {
    ContentView()
}
