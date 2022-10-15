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
    @EnvironmentObject var errorHandler: ErrorHandler
    @State private var loginViewPath = NavigationPath()
    var body: some View {
        NavigationStack(path: $loginViewPath) {
            VStack(spacing: 15) {
                HStack {
                    Text("START TO FIND YOUR RIGHT PLACE")
                        .foregroundColor(.white)
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                }
                VStack(alignment: .center, spacing: 10) {
                    HStack {
                        Text("Sign In")
                            .foregroundColor(.white)
                            .font(.title3)
                            .fontWeight(.bold)
                        Spacer()
                    }
                    AuthTextField(
                        fieldContain: $userAuth.userName,
                        fieldName: "Username",
                        fieldType: .userName,
                        hasContain: userAuth.userName.isEmpty
                    )
                    AuthTextField(
                        fieldContain: $userAuth.password,
                        fieldName: "Password",
                        fieldType: .password,
                        hasContain: userAuth.password.isEmpty
                    )
                    HStack {
                        Spacer()
                        NavigationLink {
                            
                        } label: {
                            Text("Forget password?")
                                .foregroundColor(.white.opacity(0.7))
                        }
                    }
                }
                ReuseableAuthButton(buttonName: "Sign In") {
                    Task {
                        do {
                            try await userAuth.login()
                            guard loginViewPath.count > 1 else { return }
                            loginViewPath.removeLast()
                        } catch {
                            errorHandler.handler(error: error)
                        }
                    }
                }
                HStack {
                    NavigationLink {
                        SignUpView()
                            .environmentObject(userAuth)
                            .environmentObject(errorHandler)
                    } label: {
                        Text("Sign up")
                            .foregroundColor(Color("SignUpButton"))
                    }
                    .foregroundColor(.blue)
                }
                
            }
            .modifier(ViewBackground(backgroundType: .naviBarIsHidden))
        }
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
