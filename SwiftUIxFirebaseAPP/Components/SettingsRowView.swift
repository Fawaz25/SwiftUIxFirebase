//
//  SettingsRowView.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 08/01/2024.
//

import Foundation
import SwiftUI

struct SettingsRowView: View{
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View{
        HStack(spacing: 12){
            Image(systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
        }
    }
}
