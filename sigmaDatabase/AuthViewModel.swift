//
//  AuthViewModel.swift
//  sigmaDatabase
//
//  Created by Mark Le on 2/28/25.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isLoggedIn = false
    @Published var user: User?
    
    init() {
        // Check if there's an already authenticated user when the view model initializes.
        self.user = Auth.auth().currentUser
        self.isLoggedIn = Auth.auth().currentUser != nil
        
        // Listen for changes in authentication state
        let _ = Auth.auth().addStateDidChangeListener { auth, user in
            self.user = user
            self.isLoggedIn = user != nil
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                
                return
            }
            self.user = result?.user
            self.isLoggedIn = true
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error signing up: \(error.localizedDescription)")
                print("Error details: \(error)")
                return
            }
            self.user = result?.user
            self.isLoggedIn = true
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.isLoggedIn = false
            self.user = nil
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
