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
    @Published var emaillAddress: String
    @Published var password: String
    @Published var rePassword: String
    @Published var authCode: String
    @Published var isSignIn: Bool
    @Published var isProvider: Bool
    @Published var isRenter: Bool
    @Published var userStatue: SignUpUserType = .provider
    @Published var userUID: String
//    @Published var isRead: Bool
    
    private var tempHolder: UserDM = .empty
    
    init(
        userName: String = "",
        password: String = "",
        rePassword: String = "",
        authCode: String = "",
        isSignIn: Bool = false,
        isProvider: Bool = false,
        isRenter: Bool = false,
        userUID: String = ""
//        isRead: Bool = false
    ) {
        self.emaillAddress = userName
        self.password = password
        self.rePassword = rePassword
        self.authCode = authCode
        self.isSignIn = isSignIn
        self.isProvider = isProvider
        self.isRenter = isRenter
        self.userUID = userUID
//        self.isRead = isRead
    }
    
    
    @MainActor
    func login() async throws {
        try await fireAuth.signIn(email: emaillAddress, password: password)
        self.isSignIn = true
        self.resetUsernameAndPassword()
    }
    
    @MainActor
    func createUser() async throws {
        try await fireAuth.signUp(email: emaillAddress, password: password, uid: &userUID)
        try await fireDB.createUser(uid: userUID, user: .userIntoInit(signUpType: userStatue.rawValue, isRead: user.agreeTOSPolicy))
        //FIXME: Need to test!
        try await getSendVerificationMail()
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
    
    @MainActor
    func getSendVerificationMail() async throws {
        try await fireAuth.getUserVerification()
    }
    
    @MainActor
    func emailIsVerificated() async throws {
        try await fireAuth.accountIsVerificated(action: {
            DispatchQueue.main.async {
                self.isSignIn = true
            }
        })
    }
    
    private func resetUsernameAndPassword() {
        guard !emaillAddress.isEmpty && !password.isEmpty else { return }
        emaillAddress.removeAll()
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

extension UserAuthenticationVM {
    
    func fieldReset() {
        self.emaillAddress.removeAll()
        self.password.removeAll()
        self.rePassword.removeAll()
        self.user.agreeTOSPolicy = false
        self.user.nickName.removeAll()
    }
    
}
