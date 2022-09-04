//
//  LoginView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/27.
//

import Foundation
import SwiftUI


struct LoginView: View {
    
    @EnvironmentObject var userAuth: UserAuthenticationVM
    @EnvironmentObject var appVM: AppVM

    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink("Sign up") {
                    SignUpView()
                        .environmentObject(userAuth)
                }
                .foregroundColor(.blue)
            }
            VStack(alignment: .center, spacing: 5) {
                HStack {
                    Text("Sign In")
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                }
                AuthTextField(fieldContain: $userAuth.userName, fieldName: "Username", fieldType: .userName)
                AuthTextField(fieldContain: $userAuth.password, fieldName: "Password", fieldType: .password)
            }
            .modifier(FlatGlass())
            ReuseableAuthButton(buttonName: "Sign In") {
                Task {                
                    try await userAuth.login()
                }
            }
            
        }
        .modifier(ViewBackground(backgroundType: .naviBarIsHidden))
    }
}


struct LoginView_Previews: PreviewProvider {
    static let userAuth = UserAuthenticationVM()
    static let appVM = AppVM()
    static var previews: some View {
        LoginView()
            .environmentObject(userAuth)
            .environmentObject(appVM)
    }
}
