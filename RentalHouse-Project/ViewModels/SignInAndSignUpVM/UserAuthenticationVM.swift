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
    let fireDB = FirestoreDB()
    let errorHandler = ErrorHandler()
    
    @Published var user: UserDM = .empty
    @Published var userName: String
    @Published var password: String
    @Published var isSignIn: Bool
    @Published var isProvider: Bool
    @Published var isRenter: Bool
    @Published var userStatue: SignUpUserType = .provider
    
    private var userUID: String = ""
    
    init(userName: String = "", password: String = "", isSignIn: Bool = false, isProvider: Bool = false, isRenter: Bool = false) {
        self.userName = userName
        self.password = password
        self.isSignIn = isSignIn
        self.isProvider = isProvider
        self.isRenter = isRenter
    }
    
    
    func login() async throws {
        try await fireAuth.signIn(email: userName, password: password, {
            DispatchQueue.main.async {
                self.isSignIn = true
            }
        })
    }
    
    @MainActor
    func createUser() async throws {
        try await fireAuth.signUp(email: userName, password: password, uid: &userUID)
        try await fireDB.createUser(uid: userUID, user: .userIntoInit(signUpType: userStatue.rawValue))
        self.isSignIn = true
    }
    
    func userSignOut() throws {
        try fireAuth.signOut()
        self.isSignIn = false
    }
    
    func listenUser() {
        fireAuth.currentUserListener {
            self.isSignIn = true
        }
    }
    
    func getUser() async throws {
        userUID = fireAuth.getUid()
        try await fireDB.fetchUserInto(uid: userUID, user: &user)
    }
    
}



