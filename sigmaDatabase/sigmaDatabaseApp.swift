//
//  sigmaDatabaseApp.swift
//  sigmaDatabase
//
//  Created by Mark Le on 2/26/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct sigmaDatabaseApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authViewModel = AuthViewModel()

    var body: some Scene {
       WindowGroup {
           if authViewModel.isLoggedIn {
               GradesListView()
                   .environmentObject(authViewModel)
           } else {
               LoginView()
                   .environmentObject(authViewModel)
           }
       }
    }
}
