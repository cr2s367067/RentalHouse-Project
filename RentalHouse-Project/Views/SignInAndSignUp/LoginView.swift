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
            VStack(spacing: 10) {
                Image(systemName: "photo")
                    .frame(width: 100, height: 100)
                    .background {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray.opacity(0.5))
                    }
                Text("Log In")
                    .foregroundColor(.primary)
                    .fontWeight(.bold)
                    .font(.custom("SFPro-Medium", size: 20))
                VStack(alignment: .center, spacing: 10) {
                    CustomTextFieldWithName(
                        title: "E-Mail",
                        infoContain: $userAuth.emaillAddress,
                        summitCheck: false,
                        showCautionBorder: false,
                        fieldName: "Please, Enter your email address",
                        hasContain: userAuth.emaillAddress.isEmpty,
                        fieldType: .normal
                    )
                    CustomTextFieldWithName(
                        title: "Password",
                        infoContain: $userAuth.password,
                        summitCheck: false,
                        showCautionBorder: false,
                        fieldName: "Please, Enter your password",
                        hasContain: userAuth.password.isEmpty,
                        fieldType: .secure
                    )
                    HStack {
                        NavigationLink {
                            SignUpView()
                                .environmentObject(userAuth)
                                .environmentObject(errorHandler)
                        } label: {
                            Text("Sign Up")
                                .foregroundColor(.primary)
                                .font(.custom("SFPro-Regular", size: 14))
                        }
                        Spacer()
                        NavigationLink {
                            ForgetPasswordView()
                        } label: {
                            Text("Forget password?")
                                .foregroundColor(.primary)
                                .font(.custom("SFPro-Regular", size: 14))
                        }
                    }
                }
                Spacer()
                    .frame(maxHeight: (AppVM.uiScreenHeight / 2) * 0.15)
                ReuseableLargeButton(buttonName: "Sign In") {
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
                Spacer()
                    .frame(maxHeight: (AppVM.uiScreenHeight / 2) * 0.2)
                ReuseableLargeButton(buttonName: "Sign In with Apple", isDarkGreen: false) {
//                    Task {
//                        do {
//                            try await userAuth.login()
//                            guard loginViewPath.count > 1 else { return }
//                            loginViewPath.removeLast()
//                        } catch {
//                            errorHandler.handler(error: error)
//                        }
//                    }
                }
                ReuseableLargeButton(buttonName: "Sign In with Google", isDarkGreen: false) {
//                    Task {
//                        do {
//                            try await userAuth.login()
//                            guard loginViewPath.count > 1 else { return }
//                            loginViewPath.removeLast()
//                        } catch {
//                            errorHandler.handler(error: error)
//                        }
//                    }
                }
            }
            .modifier(ViewBackground(backgroundType: .naviBarIsHidden))
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static let userAuth = UserAuthenticationVM()
    static let appVM = AppVM()
    static let errorHandler = ErrorHandler()
    static var previews: some View {
        LoginView()
            .environmentObject(userAuth)
            .environmentObject(appVM)
            .environmentObject(errorHandler)
    }
}
