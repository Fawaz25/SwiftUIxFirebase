//
//  CustomTextFields.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 04/01/2024.
//


import SwiftUI
import Foundation


struct PrimarySecureTextField: View {
    let labelText: String
    let hintText: String
    @Binding var text: String // Added binding for text input
    let image: Image
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(labelText)
                    .font(.system(size: 14))
                ZStack(alignment:.leading) {
                        image
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                        .padding(.leading, 15)
                    
                    SecureField(hintText, text: $text)
                        .padding(.leading, 30)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("PrimaryColor"), lineWidth: 1.2))
                }
            }
            .padding([.leading, .trailing])
        }
    }
}

struct PrimaryTextField: View {
    let labelText: String
    let hintText: String
    @Binding var text: String // Added binding for text input
    let image: Image
    var body: some View {
            VStack(alignment: .leading, spacing: 2) {
                Text(labelText)
                    .font(.system(size: 14))
                ZStack(alignment:.leading) {
                    image
                        .foregroundColor(Color("PrimaryColor"))
                        .bold()
                        .padding(.leading, 15)
                    
                    
                    TextField(hintText, text: $text)
                    
                        .padding(.leading, 30)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 15)
                        .stroke(Color("PrimaryColor"), lineWidth: 1.2)) // Border
                }
                
            }
            .padding([.leading, .trailing])
        
    }
}

