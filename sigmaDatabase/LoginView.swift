//
//  LoginView.swift
//  sigmaDatabase
//
//  Created by Mark Le on 2/26/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isSignUp = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                
                Button(action: {
                    if isSignUp {
                        authViewModel.signUp(email: email, password: password)
                    } else {
                        authViewModel.signIn(email: email, password: password)
                    }
                }) {
                    Text(isSignUp ? "Sign Up" : "Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    isSignUp.toggle()
                }) {
                    Text(isSignUp ? "Already have an account? Login" : "Don't have an account? Sign Up")
                }
            }
            .padding()
            .navigationTitle(isSignUp ? "Sign Up" : "Login")
        }
    }
}

#Preview {
    LoginView()
}
