//
//  SignUpView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/28.
//

import SwiftUI

struct SignUpView: View {
    
    
    @EnvironmentObject var errorHandler: ErrorHandler
    @EnvironmentObject var userAuth: UserAuthenticationVM
    @State private var signUpSstatus: AppVM.SignUpStatus = .userSelectionView
    
    var body: some View {
        switch signUpSstatus {
        case .userSelectionView:
            UserSelectionView(signUpSstatus: $signUpSstatus) {
                withAnimation {
                    signUpSstatus = .infoFieldView
                }
            }
        case .infoFieldView:
            SignUpInfoView(userAuth: userAuth, isRead: $userAuth.isRead, signUpSstatus: $signUpSstatus) {
                withAnimation {
                    signUpSstatus = .userSelectionView
                }
                userAuth.fieldReset()
            } rightAction: {
                //TODO: Navigate to identify view, if user account havn't created
                withAnimation {
                    signUpSstatus = .authenticationView
                }
            }
        case .authenticationView:
            AuthenticationView(authCode: $userAuth.authCode) {
                debugPrint("some action......")
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static let userAuth = UserAuthenticationVM()
    static var previews: some View {
        SignUpView()
            .environmentObject(userAuth)
    }
}

struct UserSelectionView: View {
    @Binding var signUpSstatus: AppVM.SignUpStatus
    var action: (()->Void)? = nil
    var body: some View {
        VStack {
            //FIXME: Fix the button size for different screen
            HStack {
                Text("I am...")
                ReuseableButton(buttonToggle: true, buttonTitle: "Renter") {
                    
                }
                ReuseableButton(buttonToggle: false, buttonTitle: "Provider") {
                    
                }
            }
            Spacer()
                .frame(maxHeight: (AppVM.uiScreenHeight / 4) * 0.3)
            Image(systemName: "photo")
                .frame(width: AppVM.uiScreenWidth * 0.9, height: (AppVM.uiScreenHeight / 2) * 0.6)
                .background {
                    Color.gray.opacity(0.3)
                        .cornerRadius(10)
                }
            Spacer()
                .frame(height: (AppVM.uiScreenHeight / 4) * 0.3)
            ReuseableLargeButton(buttonName: "Next") {
                action?()
            }
            Spacer()
        }
    }
}

struct SignUpInfoView: View {
    
    @StateObject var userAuth: UserAuthenticationVM
    
    @Binding var isRead: Bool
    @Binding var signUpSstatus: AppVM.SignUpStatus
    var leftAction: (()->Void)? = nil
    var rightAction: (()->Void)? = nil
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                HStack {
                    Text("Sign Up")
                        .foregroundColor(.primary)
                        .font(.title3)
                        .fontWeight(.heavy)
                    Spacer()
                }
                CustomTextFieldWithName(title: "Name", infoContain: $userAuth.user.nickName, fieldName: "Please, enter your name", hasContain: userAuth.user.nickName.isEmpty, fieldType: .normal)
                CustomTextFieldWithName(title: "E-Mail", infoContain: $userAuth.emaillAddress, fieldName: "Please, enter your email address", hasContain: userAuth.emaillAddress.isEmpty, fieldType: .normal)
                CustomTextFieldWithName(title: "Password", infoContain: $userAuth.password, fieldName: "Please, enter your password", hasContain: userAuth.password.isEmpty, fieldType: .secure)
                CustomTextFieldWithName(title: "Re-Password", infoContain: $userAuth.rePassword, fieldName: "Please, re-enter your password", hasContain: userAuth.rePassword.isEmpty, fieldType: .secure)
                
                HStack {
                    Button {
                        isRead.toggle()
                    } label: {
                        Image(systemName: isRead ? "checkmark.square.fill" : "square")
                            .foregroundColor(isRead ? .green : .gray)
                    }
                    Group {
                        Text("I read and agree")
                            .foregroundColor(.primary)
                        Text("term of servicee")
                            .foregroundColor(.blue)
                        Text("and")
                            .foregroundColor(.primary)
                        Text("private policy")
                            .foregroundColor(.blue)
                    }
                    .font(.custom("SFPro-Regular", size: 14))
                    Spacer()
                }
                Spacer()
                    .frame(maxHeight: (AppVM.uiScreenHeight / 2) * 0.1)
                HStack {
                    Spacer()
                    ReuseableLargeButton(buttonName: "Back", isDarkGreen: false, buttonWidth: (AppVM.uiScreenWidth / 2) * 0.8) {
                        leftAction?()
                    }
                    Spacer()
                    ReuseableLargeButton(buttonName: "Next", isDarkGreen: true, buttonWidth: (AppVM.uiScreenWidth / 2) * 0.8) {
                        rightAction?()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AuthenticationView: View {
    
    @Binding var authCode: String
    var action: (()->Void)? = nil
    
    var body: some View {
        VStack(spacing: (AppVM.uiScreenHeight / 5) * 0.2) {
            VStack(spacing: (AppVM.uiScreenHeight / 6) * 0.1) {
                HStack {
                    Text("E-mail Authentication")
                        .font(.custom("SFPro-Medium", size: 20))
                    Spacer()
                }
                HStack {
                    Text("Authentication has been sent to your email\ncheck your email, please.")
                        .foregroundColor(Color(AppVM.ColorSet.lightTextGray.rawValue))
                        .font(.custom("SFPro-Regular", size: 15))
                    Spacer()
                }
            }
            .frame(width: AppVM.uiScreenWidth * 0.97)
            
            CustomTextFieldWithName(title: "Authenticate Code", infoContain: $authCode, fieldName: "Please, Enter authenticate code", hasContain: authCode.isEmpty, fieldType: .normal)
            
            HStack {
                Text("Did not receive authentication code?")
                    .foregroundColor(Color(AppVM.ColorSet.lightTextGray.rawValue))
                Text("Re-send")
                    .foregroundColor(Color(AppVM.ColorSet.lightSpecialStyle2.rawValue))
                Spacer()
            }
            .font(.custom("SFPro-Regular", size: 14))
            .frame(width: AppVM.uiScreenWidth * 0.97)
            
            Spacer()
                .frame(maxHeight: (AppVM.uiScreenHeight / 6) * 0.1)
            ReuseableLargeButton(buttonName: "Next", isDarkGreen: true) {
                action?()
            }
            Spacer()
        }
    }
}
