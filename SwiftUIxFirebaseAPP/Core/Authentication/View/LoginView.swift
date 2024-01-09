//
//  SignupView.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 03/01/2024.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var emailText: String = ""
    @State private var nameText: String = ""
    @State private var passwordText: String = ""
    @State private var isSignupViewActive = false
    @State private var isRegisterActive = false
    @EnvironmentObject var viewModel: AuthViewModel

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView{
            VStack(alignment:.leading, spacing: 10){
                
                VStack(alignment: .leading, spacing: 30){
                    
                    Button(action: {
                        // Handle back button action here
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
//                        NavigationLink(destination: LoginView()) {
//                           
//                            SecondaryButton(text: "Login") {
//                                Task{
//                                    try await.signIn(signIn(withEmail: emailText, password: passwordText))
//                                }
//                              
////                                login()
//                                print("Navigate to LoginView")
//                            }
//                        }
                        Button{
                            Task{
                                try await viewModel.signIn(withEmail: emailText, password: passwordText)
                            }
                        } label:{
                            HStack{
                                Spacer()
                                Text("Login")
                                    .font(.system(size: 16))
                                    .foregroundColor(.white)
                                    .bold()
                                Spacer()
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("PrimaryColor"))
                            .frame(maxWidth: .infinity)

                            .cornerRadius(15)
                        }
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
//        .ignoresSafeArea(.keyboard, edges: .bottom)
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




#Preview {
    LoginView()
}
