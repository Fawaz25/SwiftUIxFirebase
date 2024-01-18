//
//  SignupView.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 03/01/2024.
//

import SwiftUI
import Firebase

struct SignupView: View {
    @State private var emailText: String = ""
    @State private var nameText: String = ""
    @State private var passwordText: String = ""
    @State private var confirmpasswordText: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @State private var isRegisterActive = false

    @EnvironmentObject var viewModel: AuthViewModel

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        if isRegisterActive{
            LoginView()
        }
        else{
            content
        }
    }
    
    var content: some View{
        NavigationView{
            VStack(alignment:.leading, spacing: 10){
                
                VStack(alignment: .leading, spacing: 30){
                    
                    Button(action: {
                        // Handle back button action here
//                        self.presentationMode.wrappedValue.dismiss()
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(FontStyles.HeadingFont)
                            .foregroundColor(Color.black)
                            .padding(.leading)
                    }
                    
                    HStack{
                        Text("Register")
                            .font(FontStyles.HeadingFont)
                            .foregroundColor(Color("PrimaryColor"))
                            .bold()
                        Spacer()
                    }     .padding(.leading)
                    
                    
                }
                VStack(alignment: .leading,spacing: 30){
                    Group {
                        Text("Create an")
                            .font(FontStyles.SubheadingFont) +
                        Text(" account")
                            .foregroundColor(Color("PrimaryColor"))
                            .bold()
                            .font(FontStyles.SubheadingFont) +
                        Text(" to access all the\nfeatures of")
                            .font(FontStyles.SubheadingFont) +
                        Text(" Maxpense")
                            .font(FontStyles.SubheadingFont)
                            .bold()
                    }.padding(.leading)
                    
                    VStack(alignment:.leading,spacing:25){
                        PrimaryTextField(labelText: "Email", hintText: "Ex: abc@example.com", text: $emailText, image:  Image(systemName: "at"))
                        PrimaryTextField(labelText: "Your Name", hintText: "Ex. Saul Ramirez", text: $nameText,image:  Image(systemName: "person"))
                        PrimarySecureTextField(labelText: "Your Password", hintText: "Password", text: $passwordText,image:  Image(systemName: "lock"))
                        ZStack(alignment: .trailing){
                            PrimarySecureTextField(labelText: "Confirm Password", hintText: "re-enter Password", text: $confirmpasswordText,image:  Image(systemName: "lock"))
                            
                            
                            if !passwordText.isEmpty && !confirmpasswordText.isEmpty{
                                if passwordText == confirmpasswordText{
                                    Image(systemName: "checkmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.systemGreen))
                                        .padding([.trailing,.top])
                                        .padding(.trailing, 10)
                                }else{
                                    Image(systemName: "xmark.circle.fill")
                                        .imageScale(.large)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(.systemRed))
                                        .padding([.trailing,.top])
                                        .padding(.trailing, 10)

                                }
                            }
                        }
                       
                        SecondaryButton(text: "Register") {
                                Task{
                                        try await viewModel.createUser(withEmail: emailText, password: passwordText, fullName: nameText){
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
                        
                        }.padding([.top,.bottom])
                    }

                HStack{
                    Spacer()
                    clickableText(text: "Already have an account? ", textButton: "Login", viewDestination: AnyView(LoginView()))
                    Spacer()
                }
                Spacer()

            }
            .padding([.leading,.trailing])
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)

        .navigationBarBackButtonHidden()
    }
}

extension SignupView: AuthenticationFormProtocol{
    var formIsValid: Bool{
        return !emailText.isEmpty
        && emailText.contains("@")
        && !passwordText.isEmpty
        && passwordText.count > 5
        && confirmpasswordText == passwordText
        && !nameText.isEmpty
    }
}


#Preview {
    SignupView()
}
