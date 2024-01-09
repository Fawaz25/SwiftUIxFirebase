//
//  File.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 03/01/2024.
//

import Foundation
import SwiftUI

enum ButtonType {
    case email
    case google
}


struct PrimaryButton: View {
    let text: String
    let image: Image
    let buttonType: ButtonType
    let action: () -> Void // Closure to handle button action/navigation

    var body: some View {
        
        Button(action: action) {
            HStack {
                if buttonType == .email {
                    Text(text)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .bold()
                }
                image
                    .resizable()
                    .frame(width: 18, height: 18)
                    .foregroundColor(Color(hex: "575DFB"))
                    .bold()
                if buttonType == .google {
                    Text(text)
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .bold()
                }
            }
//            .cornerRadius(10)
            .frame(maxWidth: .infinity)
            .padding()
        }
        .background()
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 1.5)
            )
        .padding([.leading,.trailing])
    }
}



struct SecondaryButton: View {
    let text: String
    let action: () -> Void // Closure to handle button action/navigation

    var body: some View {
//        VStack(alignment:.leading){?
            Button(action: action) {
                HStack{
                    Spacer()
                    Text(text)
                        .font(.system(size: 16))
                        .foregroundColor(.white)
                        .bold()
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            
            .padding()
            .background(Color("PrimaryColor"))
            .frame(maxWidth: .infinity)

            .cornerRadius(15)
//        }?
//        .frame(maxWidth: .infinity)

    }
}

