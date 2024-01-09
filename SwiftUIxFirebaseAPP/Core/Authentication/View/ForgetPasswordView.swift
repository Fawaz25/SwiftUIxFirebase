//
//  SignupView.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 03/01/2024.
//

import SwiftUI

struct ForgetPasswordView: View {
    enum PasswordResetState {
            case email
            case verification
            case newPassword
        }
    @State private var emailText: String = ""
    @State private var verificationText: String = ""
    @State private var passwordText: String = ""
    @State private var isSignupViewActive = false
    @State private var passwordResetState: PasswordResetState = .email

    @State private var isRegisterActive = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView{
            VStack(alignment:.leading, spacing: 10){
                
                VStack(alignment: .leading, spacing: 30){
                    
                    Button(action: {
                        // Handle back button action here
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(FontStyles.HeadingFont)
                            .foregroundColor(Color.black)
                            .padding(.leading)
                    }
                    
                    HStack{
                        Text("Forget Password?")
                            .font(FontStyles.HeadingFont)
                            .foregroundColor(Color("PrimaryColor"))
                            .bold()
                        Spacer()
                    }     .padding(.leading)
                    
                }
                VStack(alignment: .leading,spacing: 35){
                    Group {
                        Text("Recover you password if you have forgot the password!")
                            .font(FontStyles.SubheadingFont)
                    }.padding(.leading)
                    
                    VStack(alignment: .leading,spacing:30){
                        switch passwordResetState  {
                        case .email:
                            PrimaryTextField(labelText: "Email", hintText: "Ex: abc@example.com", text: $emailText, image:  Image(systemName: "at"))

                        case .verification:
                            PrimaryTextField(labelText: "Verification", hintText: "Enter verification code", text: $verificationText, image: Image(systemName: "lock"))

                        case .newPassword:
                            PrimarySecureTextField(labelText: "New Password", hintText: "Enter new password", text: $passwordText, image: Image(systemName: "lock"))
                        }

                        switch passwordResetState {
                        case .email:
                            SecondaryButton(text: "Submit") {
                                
                                passwordResetState = .verification
                            }                        .padding([.leading,.trailing])

                        case .verification:
                            SecondaryButton(text: "Submit") {
                                
                                passwordResetState = .newPassword
                            }                        .padding([.leading,.trailing])

                        case .newPassword:
                                SecondaryButton(text: "Confirm") {
                                print("New password submitted")
                            }                        .padding([.leading,.trailing])
                        }
                    }
                    
                }

                Spacer()

            }
            
            .padding([.leading,.trailing])

        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden()

        
    }
}




#Preview {
    ForgetPasswordView()
}
