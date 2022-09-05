//
//  Firestore.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/3.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


class FirestoreDB {
    
    let db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func createUser(uid: String, user: UserDM) async throws {
        let userPath = db.collection("Users").document(uid)
        try await userPath.setData([
            "nickName" : user.nickName,
            "signUpType" : user.signUpType,
            "mobile" : user.mobile,
            "lineID" : user.lineID,
            "profileImagePath" : user.profileImagePath
        ])
    }

    
    func fetchUserInto(uid: String, user: inout UserDM) async throws {
        let userPath = db.collection("Users").document(uid)
        user = try await userPath.getDocument(as: UserDM.self)
    }
    
    
}
