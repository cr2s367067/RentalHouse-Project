//
//  Firestore.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/3.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum CollectionType: String {
    case users = "Users"
    case rooms = "Rooms"
}

class FirestoreDB {
    
    let db: Firestore
    var collectionType: CollectionType = .users
    
    init() {
        db = Firestore.firestore()
    }
    
    func documentPath() -> DocumentReference {
        return db.collection("").document("")
    }
    
    func createUser(uid: String, user: UserDM) async throws {
        collectionType = .users
        let userPath = db.collection(collectionType.rawValue).document(uid)
        try await userPath.setData([
            "nickName" : user.nickName,
            "signUpType" : user.signUpType,
            "mobile" : user.mobile,
            "lineID" : user.lineID,
            "profileImagePath" : user.profileImagePath
        ])
    }
    
    func fetchUserInto(uid: String, user: inout UserDM) async throws {
        collectionType = .users
        let userPath = db.collection(collectionType.rawValue).document(uid)
        user = try await userPath.getDocument(as: UserDM.self)
    }
    
    
    func roomUploadProcess(uid: String, room info: RoomPostDM) async throws {
        collectionType = .rooms
        let roomPath = db.collection(collectionType.rawValue).document(uid)
        try await roomPath.setData([
            "roomSize" : info.roomSize,
            "roomAddress" : info.roomAddress,
            "rentalPrice" : info.rentalPrice,
            "additionalInfo" : info.additionalInfo,
            "tosAgree" : info.tosAgree,
            "providerType" : info.providerType,
            "roomCoverImage" : info.roomCoverImage,
            "uploadTime" : Date()
        ])
    }
    
    func fetchRoomUpload(uid: String) async throws {
        
    }
    
}
