//
//  ContentView.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 03/01/2024.
//

import SwiftUI

struct LandingView: View {
    @State private var isSignupViewActive = false
    @State private var isLoginActive = false
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading){
                VStack(alignment: .leading, spacing: 5) {
                    Spacer()
                    
                    Text("Welcome to")
                        .font(.system(size: 24))
                    Text("MaxPense")
                        .font(.system(size: 40))
                        .bold()
                        .foregroundColor(Color(hex:"575DFB"))
                    Text("A place where you can track all your expenses and incomes...")
                        .font(FontStyles.SubheadingFont)
                }.padding()
                
                VStack(spacing:25 ){
                    HStack{
                        
                        Text("Let’s Get Started...")
                            .font(.system(size: 17.32))
                            .padding([.leading,.trailing,.top])
                        Spacer()
                    }
                    VStack{
                        
                        
                        NavigationLink(destination: SignupView(), isActive: $isSignupViewActive) {
                            PrimaryButton(text: "Continue with Google", image: Image(.google), buttonType: .google) {
                                self.isSignupViewActive = true
                            }
                        }
                        
                        NavigationLink(destination: SignupView(), isActive: $isLoginActive) {
                            PrimaryButton(text: "Continue with Email", image: Image(systemName: "at"),buttonType: .email){
                                self.isLoginActive = true
                            }
                            
                        }
                        .padding(.bottom)

                        clickableText(text: "Already have an account? ", textButton: "Login", viewDestination: AnyView(LoginView()))
                        Spacer()
                    }
                }
            }
            .padding()
        }
    }
}


struct clickableText: View{
    
    let text: String
    let textButton: String
    let viewDestination: AnyView
    
    
    var body: some View {
        HStack{
            
            Text(text)
                .font(FontStyles.SubheadingFont)
            
            NavigationLink(destination: viewDestination) {
                Text(textButton)
                    .font(.subheadline)
                    .bold()
                    .underline(true, color: Color(hex:"575DFB"))
                    .foregroundColor(Color(hex:"575DFB"))
            }
        }
    }
}

#Preview {
    LandingView()
}
