//
//  SignInAndSignUpViewModel.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/27.
//

import Foundation
import SwiftUI

enum LoginTextFieldType {
    case userName
    case password
}

enum SignUpUserType: String {
    case provider = "Provider"
    case renter = "Renter"
}

class UserAuthenticationVM: ObservableObject {
    
    @Published var userName: String
    @Published var password: String
    @Published var isSignIn: Bool
    @Published var isProvider: Bool
    @Published var isRenter: Bool
    
    init(userName: String = "", password: String = "", isSignIn: Bool = false, isProvider: Bool = false, isRenter: Bool = false) {
        self.userName = userName
        self.password = password
        self.isSignIn = isSignIn
        self.isProvider = isProvider
        self.isRenter = isRenter
    }
    
}

struct AuthTextField: View {
    var fieldContain: Binding<String>
    var fieldName = ""
    var fieldType: LoginTextFieldType = .userName
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if fieldType == .userName {
                Text(fieldName)
                TextField("", text: fieldContain)
                    .textFieldStyle(.roundedBorder)
            } else {
                Text(fieldName)
                SecureField("", text: fieldContain)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding()
        .frame(width: AppVM.uiScreenWidth * 0.9, height: AppVM.uiScreenHeight * 0.09, alignment: .center)
    }
}

struct AuthTextField_preview: PreviewProvider {
    static var previews: some View {
        AuthTextField(fieldContain: .constant(""), fieldName: "Username", fieldType: .userName)
    }
}

struct SignUpUserButton: View {
    var isSelected = false
    var userType: SignUpUserType = .provider
    var buttonAct: (() -> Void)? = nil
    var body: some View {
        VStack {
            if userType == .provider {
                Button {
                    buttonAct?()
                } label: {
                    HStack {
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(isSelected ? .green : .black)
                        Text(userType.rawValue)
                            .foregroundColor(.primary)
                    }
                }
            } else {
                Button {
                    buttonAct?()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(isSelected ? .green : .black)
                        Text(userType.rawValue)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

struct SignUpUserButton_preview: PreviewProvider {
    static var previews: some View {
        HStack {
            SignUpUserButton(userType: .provider)
        }
    }
}
    
