//
//  ContentView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/27.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userAuth: UserAuthenticationVM
    var body: some View {
        if userAuth.isSignIn {
            HomeView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
