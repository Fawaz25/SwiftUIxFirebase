//
//  AuthViewModel.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 04/01/2024.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


protocol AuthenticationFormProtocol{
    var formIsValid: Bool { get }
}

@MainActor
class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    
    init(){
        self.userSession = Auth.auth().currentUser
        
        Task{
            await fetchUser()
        }
    }
    
    
    func signIn(withEmail email: String, password: String, completion: @escaping (Bool, String) -> Void) async throws{
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            completion(true, "User successfully Logged In")
            await fetchUser()
        } catch {
            print("DEBUG: Failed to sign in user with error \(error.localizedDescription)")
            completion(false, "Error: \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullName: String, completion: @escaping (Bool, String) -> Void) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, email: email, fullName: fullName)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
            completion(true, "User created successfully")
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            completion(false, "Error: \(error.localizedDescription)")
        }
    }
    
    func signOut(){
        do{
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            
        }catch{
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")

        }
    }
    
    func deleteAccount() async {
        do {
            guard let user = Auth.auth().currentUser else {
                return
            }

            try await user.delete()

            let uid = user.uid
            try await Firestore.firestore().collection("users").document(uid).delete()

            self.userSession = nil
            self.currentUser = nil

        } catch {
            print("DEBUG: Failed to delete account with error \(error.localizedDescription)")
        }
    }
    
    func fetchUser() async { 
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
        print("DEBUG: Current User is \(String(describing: self.currentUser))")

    }
    
    func forgotPassword(email: String, completion: @escaping (Bool, String) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("Error sending password reset email: \(error.localizedDescription)")
                completion(false, "Error: \(error.localizedDescription)")
            } else {
                print("Password reset email sent successfully")
                completion(true, "Password reset email sent successfully")
            }
        }
    }

}
