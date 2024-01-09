//
//  AuthViewModel.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 04/01/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    
    init(){
        self.userSession = Auth.auth().currentUser
    }
    
    
    func signIn(withEmail email: String, password: String) async throws{
        print("Sign In...")

    }
    
    func createUser(withEmail email: String, password: String, fullName: String) async throws{
        do{
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id:result.user.uid, email: email, fullName: fullName)
            let encodedUser = try Firestore.Encoder().encode(user) 
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)

        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        
    }
    
    func deleteAccount(){
        
    }
    
    func fetchUser() async { 
        do {
            guard let uid = Auth.auth().currentUser?.uid else { return }
            let snapshot = try await Firestore.firestore().collection("users").document(uid).getDocument()
            // Process 'snapshot' data here
            self.currentUser = try? snapshot.data(as: User.self)
        } catch {
            // Handle the error appropriately
            print("Error fetching user: \(error.localizedDescription)")
        }
    }
}
