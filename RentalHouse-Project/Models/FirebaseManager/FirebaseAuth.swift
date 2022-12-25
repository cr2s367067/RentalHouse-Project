//
//  FirebaseAuth.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/3.
//

import Foundation
import FirebaseAuth

class FirebaseUserAuth {
    
    let auth: Auth
    
    init() {
        auth = Auth.auth()
    }
    
    func getUid() -> String {
        return auth.currentUser?.uid ?? ""
    }
    
//    func signIn(email: String, password: String, _ completion: () -> Void) async throws {
//        try await auth.signIn(withEmail: email, password: password)
//        completion()
//    }
    
    func signIn(email: String, password: String) async throws {
        try await auth.signIn(withEmail: email, password: password)
    }
    
    func signUp(email: String, password: String, uid: inout String) async throws {
        try await auth.createUser(withEmail: email, password: password)
        uid = auth.currentUser?.uid ?? ""
    }
    
    func signOut() throws {
        try auth.signOut()
    }
    
    func reloadUserData() async throws {
        try await auth.currentUser?.reload()
    }
    
    func currentUserListener(action: (()->Void)? = nil) {
        auth.addStateDidChangeListener { auth, currentUser in
            if currentUser != nil {
                Task {
                    do {
                        try await self.accountIsVerificated(action: action)
                    } catch {
                        fatalError()
                    }
                }
            }
        }
    }
    
    func getUserVerification() async throws {
        try await self.reloadUserData()
        if auth.currentUser != nil && !(auth.currentUser?.isEmailVerified ?? false) {
            try await auth.currentUser?.sendEmailVerification()
        }
    }
    
    
    
    func accountIsVerificated(action: (()->Void)? = nil) async throws {
        try await self.reloadUserData()
        if auth.currentUser?.isEmailVerified ?? false {
            action?()
        }
    }
    
    func sendingPasswordReset(with email: String) async throws {
        try await auth.sendPasswordReset(withEmail: email)
    }
    
    func passwordUpdate(from password: String) async throws {
        try await auth.currentUser?.updatePassword(to: password)
    }
    
}
