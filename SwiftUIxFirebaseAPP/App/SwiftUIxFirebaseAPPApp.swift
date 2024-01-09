//
//  SwiftUIxFirebaseAPPApp.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 03/01/2024.
//

import SwiftUI
import Firebase

@main
struct SwiftUIxFirebaseAPPApp: App {
    @StateObject var viewModel = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
