//
//  SignupView.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 03/01/2024.
//

import SwiftUI
import Firebase
import GoogleSignIn
import FirebaseAuth

struct LoginView: View {
    @State private var emailText: String = ""
    @State private var nameText: String = ""
    @State private var passwordText: String = ""
    @State private var isSignupViewActive = false
    @State private var isRegisterActive = false
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showAlert = false
    @State private var alertMessage = ""

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView{
            VStack(alignment:.leading, spacing: 10){
                
                VStack(alignment: .leading, spacing: 30){
                    
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(FontStyles.HeadingFont)
                            .foregroundColor(Color.black)
                            .padding(.leading)
                    }
                    
                    HStack{
                        Text("Login")
                            .font(FontStyles.HeadingFont)
                            .foregroundColor(Color("PrimaryColor"))
                            .bold()
                        Spacer()
                    }     .padding(.leading)
                    
                }
                VStack(alignment: .leading,spacing: 35){
                    Group {
                        Text("Login now to track all your expenses and income at a place!")
                            .font(FontStyles.SubheadingFont)
                    }.padding(.leading)
                    
                    VStack(alignment: .leading,spacing:30){
                        PrimaryTextField(labelText: "Email", hintText: "Ex: abc@example.com", text: $emailText, image:  Image(systemName: "at"))
                        VStack(alignment: .leading,spacing:10){
                            PrimarySecureTextField(labelText: "Your Password", hintText: "Password", text: $passwordText,image:  Image(systemName: "lock"))
                            
                            NavigationLink(destination: ForgetPasswordView()){
                                Text("Forgot Password?")
                                    .padding(.leading)
                                    .font(.system(size: 12))
                                    .foregroundColor(Color("PrimaryColor"))
                                    .underline()
                            }
                        }
                        
                        SecondaryButton(text: "Login") {
                            Task{
                                try await viewModel.signIn(withEmail: emailText, password: passwordText){
                                            success, errorMessage in
                                        if success {
                                            isRegisterActive.toggle()

                                        } else {
                                            alertMessage = errorMessage
                                            showAlert = true
                                        }
                                    }
                                }
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                            }
                            .disabled(!formIsValid)
                            .opacity(formIsValid ? 1.0 : 0.5)
                            .padding([.leading,.trailing])
                        
                        Divider()
                           .background(Color.black)
                           .frame(height: 2)
                           .padding(.horizontal)
                            
                        
                        NavigationLink(destination: SignupView(), isActive: $isSignupViewActive) {
                            PrimaryButton(text: "Continue with Google", image: Image(.google), buttonType: .email) {
                                
                                self.isSignupViewActive = true
                            }
                        }
                        
                        VStack(){
                        }
                    }
                    
                }

                HStack{
                    Spacer()
                    clickableText(text: "Don’t have an account? ", textButton: "Register", viewDestination: AnyView(SignupView()))
                    Spacer()
                }
                Spacer()

            }
            
            .padding([.leading,.trailing])

        }
        .navigationBarBackButtonHidden()
        
    }
    
    func login(){
        Auth.auth().signIn(withEmail: emailText, password: passwordText){
            result, error in
            if error != nil{
                print(error!.localizedDescription)
            }
        }
    }
}

extension LoginView: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !emailText.isEmpty
        && emailText.contains("@")
        && !passwordText.isEmpty
        && passwordText.count > 5
    }
}

#Preview {
    LoginView()
}
