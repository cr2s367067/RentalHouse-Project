//
//  SignUpView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/28.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var userAuth: UserAuthenticationVM
    @EnvironmentObject var errorHandler: ErrorHandler
    
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Sign Up")
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                }
                AuthTextField(fieldContain: $userAuth.userName, fieldName: "Username", fieldType: .userName)
                AuthTextField(fieldContain: $userAuth.password, fieldName: "Password", fieldType: .password)
                HStack {
                    Spacer()
                    SignUpUserButton(isSelected: userAuth.isProvider, userType: .provider) {
                        userAuth.isProvider = true
                        if userAuth.isRenter {
                            userAuth.isRenter = false
                        }
                    }
                    Spacer()
                    SignUpUserButton(isSelected: userAuth.isRenter, userType: .renter) {
                        userAuth.isRenter = true
                        if userAuth.isProvider {
                            userAuth.isProvider = false
                        }
                    }
                    Spacer()
                }
                ReuseableAuthButton(buttonName: "Sign Up") {
                    Task {
                        do {
                            try await userAuth.createUser()
                        } catch {
                            errorHandler.handler(error: error)
                        }
                    }
                }
            }
            .modifier(FlatGlass())
        }
        .modifier(ViewBackground(backgroundType: .naviBarIsShown))
    }
}

struct SignUpView_Previews: PreviewProvider {
    static let userAuth = UserAuthenticationVM()
    static var previews: some View {
        SignUpView()
            .environmentObject(userAuth)
    }
}
