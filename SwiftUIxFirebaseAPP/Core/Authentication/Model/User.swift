//
//  User.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 08/01/2024.
//

import Foundation

struct User: Identifiable, Codable{
    
    let id : String
    let email : String
    let fullName : String
    
    var initials: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullName){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}
