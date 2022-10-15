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

enum UserDashboardContainTitle: String {
    case nickName = "Nick Name"
    case mobileNum = "Mobile Number"
    case lineID = "Line ID"
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
    @Published var userUID: String
    
    private var tempHolder: UserDM = .empty
    
    init(userName: String = "", password: String = "", isSignIn: Bool = false, isProvider: Bool = false, isRenter: Bool = false, userUID: String = "") {
        self.userName = userName
        self.password = password
        self.isSignIn = isSignIn
        self.isProvider = isProvider
        self.isRenter = isRenter
        self.userUID = userUID
    }
    
    
    @MainActor
    func login() async throws {
        try await fireAuth.signIn(email: userName, password: password)
        self.isSignIn = true
        self.resetUsernameAndPassword()
    }
    
    @MainActor
    func createUser() async throws {
        try await fireAuth.signUp(email: userName, password: password, uid: &userUID)
        try await fireDB.createUser(uid: userUID, user: .userIntoInit(signUpType: userStatue.rawValue))
        self.isSignIn = true
        resetUsernameAndPassword()
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
    
    @MainActor
    func getUser() async throws {
        userUID = fireAuth.getUid()
        try await fireDB.fetchUserInto(uid: userUID, user: &user)
        userStatue = .init(rawValue: user.signUpType) ?? .provider
    }
    
    private func resetUsernameAndPassword() {
        guard !userName.isEmpty && !password.isEmpty else { return }
        userName.removeAll()
        password.removeAll()
        isRenter = false
        isProvider = false
    }
    
}

extension UserAuthenticationVM {
    //User info update function
    @MainActor
    func userUpdate() async throws {
        userUID = fireAuth.getUid()
        guard !AppVM.isSame(lhs: user, rhs: tempHolder) else {
            debugPrint("Data hasn't change")
            return
        }
        debugPrint("Data is change ready to upload")
        try await fireDB.userInfoUpdate(uid: userUID, user: &user)
    }
    
    func storUserInfoInTemp() {
        self.tempHolder = user
    }
}
