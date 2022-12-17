//
//  ForgetPasswordView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/12/16.
//

import SwiftUI

struct ForgetPasswordView: View {
    
    @EnvironmentObject var userAuth: UserAuthenticationVM
    @State private var forgetPasswordStatus: AppVM.ForgetPasswordStatus = .recoveryEmailView
    @State private var recoverEmailAddress = ""
    @State private var authCode = ""
    @State private var firstPassword = ""
    @State private var secondPassword = ""
    
    var body: some View {
        switch forgetPasswordStatus {
        case .recoveryEmailView:
            RecoveryEmailView(recoveryEmailAddress: $userAuth.emaillAddress) {
                withAnimation {
                    forgetPasswordStatus = .authenticationView
                }
            }
        case .authenticationView:
            AuthenticationView(authCode: $userAuth.authCode) {
                debugPrint("some action")
                withAnimation {
                    forgetPasswordStatus = .resetPassswordView
                }
            }
        case .resetPassswordView:
            ResetPasswordView(firstPassword: $userAuth.password, secondPassword: $userAuth.rePassword) {
                debugPrint("Set new password")
            }
        }
        
    }
}

struct ForgetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgetPasswordView()
    }
}

struct RecoveryEmailView: View {
    @Binding var recoveryEmailAddress: String
    var action: (()->Void)? = nil
    var body: some View {
        VStack(spacing: (AppVM.uiScreenHeight / 5) * 0.2) {
            VStack(spacing: (AppVM.uiScreenHeight / 6) * 0.1) {
                HStack {
                    Text("Forget Password")
                        .font(.custom("SFPro-Medium", size: 20))
                    Spacer()
                }
                HStack {
                    Text("Enter your e-mail address, please.")
                        .foregroundColor(Color(AppVM.ColorSet.lightTextGray.rawValue))
                        .font(.custom("SFPro-Regular", size: 15))
                    Spacer()
                }
            }
            .frame(width: AppVM.uiScreenWidth * 0.97)
            
            CustomTextFieldWithName(title: "Email Address", infoContain: $recoveryEmailAddress, fieldName: "Please, Enter authenticate code", hasContain: recoveryEmailAddress.isEmpty, fieldType: .normal)
            
            Spacer()
                .frame(maxHeight: (AppVM.uiScreenHeight / 6) * 0.1)
            ReuseableLargeButton(buttonName: "Next", isDarkGreen: true) {
                action?()
            }
            Spacer()
        }
    }
}

struct ResetPasswordView: View {
    
    @Binding var firstPassword: String
    @Binding var secondPassword: String
    var action: (()->Void)? = nil
    
    
    var body: some View {
        VStack(spacing: (AppVM.uiScreenHeight / 5) * 0.2) {
            HStack {
                Text("Reset Password")
                    .foregroundColor(Color(AppVM.ColorSet.lightTextGray.rawValue))
                    .font(.custom("SFPro-Medium", size: 20))
                Spacer()
            }
            .frame(width: AppVM.uiScreenWidth * 0.97)
            CustomTextFieldWithName(title: "Password", infoContain: $firstPassword, fieldName: "Enter your new password, please", hasContain: firstPassword.isEmpty, fieldType: .secure)
            CustomTextFieldWithName(title: "Confirm Password", infoContain: $secondPassword, fieldName: "Enter your password again, please", hasContain: secondPassword.isEmpty, fieldType: .secure)
            Spacer()
                .frame(maxHeight: (AppVM.uiScreenHeight / 6) * 0.1)
            ReuseableLargeButton(buttonName: "Confirm", isDarkGreen: true) {
                action?()
            }
            Spacer()
        }
    }
}
