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
    
    @State private var signUpSstatus: AppVM.SignUpStatus = .infoFieldView
    
    @State private var isRead = false
    
    var body: some View {
        switch signUpSstatus {
        case .userSelectionView:
            VStack {
                Spacer()
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
                ReuseableLargeButton(buttonName: "Next") {
                    withAnimation {
                        signUpSstatus = .infoFieldView
                    }
                }
                Spacer()
            }
        case .infoFieldView:
            VStack {
                VStack(spacing: 20) {
                    HStack {
                        Text("Sign Up")
                            .foregroundColor(.primary)
                            .font(.title3)
                            .fontWeight(.heavy)
                        Spacer()
                    }
                    CustomTextFieldWithName(title: "Name", infoContain: .constant("testName"), fieldName: "Please, enter your name", hasContain: false, fieldType: .normal)
                    CustomTextFieldWithName(title: "E-Mail", infoContain: $userAuth.userName, fieldName: "Please, enter your email address", hasContain: userAuth.userName.isEmpty, fieldType: .normal)
                    CustomTextFieldWithName(title: "Password", infoContain: $userAuth.password, fieldName: "Please, enter your password", hasContain: userAuth.password.isEmpty, fieldType: .secure)
                    CustomTextFieldWithName(title: "Re-Password", infoContain: $userAuth.password, fieldName: "Please, re-enter your password", hasContain: userAuth.password.isEmpty, fieldType: .secure)
                    
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
                            signUpSstatus = .userSelectionView
    //                        Task {
    //                            do {
    //                                try await userAuth.createUser()
    //                            } catch {
    //                                errorHandler.handler(error: error)
    //                            }
    //                        }
                        }
                        Spacer()
                        ReuseableLargeButton(buttonName: "Next", isDarkGreen: true, buttonWidth: (AppVM.uiScreenWidth / 2) * 0.8) {
                            //TODO: Navigate to identify view, if user account havn't created
                        }
                        Spacer()
                    }
                }
            }
            .modifier(ViewBackground(backgroundType: .naviBarIsShown))
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
