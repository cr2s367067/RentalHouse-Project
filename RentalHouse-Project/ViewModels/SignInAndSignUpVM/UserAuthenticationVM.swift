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
    
    let fireAuth = FirebaseUserAuth()
    
    @Published var userName: String
    @Published var password: String
    @Published var isSignIn: Bool
    @Published var isProvider: Bool
    @Published var isRenter: Bool
    
    @Published var userStatue: SignUpUserType = .provider
    
    init(userName: String = "", password: String = "", isSignIn: Bool = false, isProvider: Bool = false, isRenter: Bool = false) {
        self.userName = userName
        self.password = password
        self.isSignIn = isSignIn
        self.isProvider = isProvider
        self.isRenter = isRenter
    }
    
    @MainActor
    func login() async throws {
        do {
            try await fireAuth.signIn(email: userName, password: password, {
                self.isSignIn = true
            })
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func createUser() async throws {
        do {
            try await fireAuth.signUp(email: userName, password: password, {
                self.isSignIn = true
            })
        } catch {
            print("error: \(error.localizedDescription)")
        }
    }
    
}



