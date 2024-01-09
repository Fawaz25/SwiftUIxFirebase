//
//  ContentView.swift
//  SwiftUIxFirebaseAPP
//
//  Created by Fawaz Ahmed Tahir on 05/01/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        Group{
            if viewModel.userSession != nil{
                DashboardView()
            }
            else{
                LandingView()
            }
        }
    }
}

#Preview {
    ContentView()
}
