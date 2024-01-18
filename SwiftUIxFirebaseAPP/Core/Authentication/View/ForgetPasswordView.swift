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
//            case newPassword
        }
    @State private var emailText: String = ""
    @State private var verificationText: String = ""
    @State private var passwordText: String = ""
    @State private var isSignupViewActive = false
    @State private var passwordResetState: PasswordResetState = .email
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isRegisterActive = false
    @EnvironmentObject var viewModel: AuthViewModel

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
                            
                            SecondaryButton(text: "Submit") {
                                Task{
                                        viewModel.forgotPassword(email: emailText) { success, errorMessage in
                                        if success {
                                            passwordResetState = .verification
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

                        case .verification:
                            PasswordResetSuccessView()
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


struct PasswordResetSuccessView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 48))
                .foregroundColor(.green)
            
            Text("Password Reset Email Sent Successfully")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .foregroundColor(.primary)
            
            Text("Please check your inbox to update your password.")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10)
            .fill(Color.white)) // You can choose a color that fits your theme
        
        .padding()
    }
}



extension ForgetPasswordView: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !emailText.isEmpty
    }
}


#Preview {
    ForgetPasswordView()
}
