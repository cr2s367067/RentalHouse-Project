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

enum PostSpot {
    case inside
    case external
}

enum UploadMethod {
    case create, update
}

class FirestoreDB {
    
    let db: Firestore
    var collectionType: CollectionType = .users
    
    init() {
        db = Firestore.firestore()
    }
    
    //MARK: - User's create, fetch and update functions
    func createUser(uid: String, user: UserDM) async throws {
        collectionType = .users
        let userPath = db.collection(collectionType.rawValue).document(uid)
        try await userPath.setData([
            "nickName" : user.nickName,
            "signUpType" : user.signUpType,
            "mobile" : user.mobile,
            "lineID" : user.lineID,
            "profileImagePath" : user.profileImagePath,
            "accountVerificated" : user.accountVerificated,
            "agreeTOSPolicy" : user.agreeTOSPolicy
        ])
    }
    
    func fetchUserInto(uid: String, user: inout UserDM) async throws {
        collectionType = .users
        let userPath = db.collection(collectionType.rawValue).document(uid)
        user = try await userPath.getDocument(as: UserDM.self)
    }
    
    func userInfoUpdate(uid: String, user: inout UserDM) async throws {
        collectionType = .users
        let userPath = db.collection(collectionType.rawValue).document(uid)
        _ = try await userPath.updateData([
            "nickName" : user.nickName,
            "mobile" : user.mobile,
            "lineID" : user.lineID,
            "profileImagePath" : user.profileImagePath
        ])
        user = try await userPath.getDocument(as: UserDM.self)
    }
    
}

//MARK: - Room's post and fetch functions
extension FirestoreDB {
    
    func roomUploadProcess(
        uid: String,
        room info: inout RoomPostDM,
        spot upload: PostSpot,
        method create: UploadMethod,
        roomUID: String
    ) async throws {
        collectionType = .rooms
        switch upload {
        case .inside:
            let roomPath = db.collection(collectionType.rawValue).document(uid).collection(uid).document(roomUID)
            switch create {
            case .create:
                _  = try await roomPath.setData([
                    "roomSize" : info.roomSize,
                    "roomAddress" : info.roomAddress,
                    "rentalPrice" : info.rentalPrice,
                    "additionalInfo" : info.additionalInfo,
                    "tosAgree" : info.tosAgree,
                    "providerType" : info.providerType,
                    "roomsImage" : info.roomsImage,
                    "providerInfo" : uid,
                    "isOnPublic" : info.isOnPublic,
                    "uploadTime" : Date()
                ])
            case .update:
                _ = try await roomPath.updateData([
                    "roomSize" : info.roomSize,
                    "roomAddress" : info.roomAddress,
                    "rentalPrice" : info.rentalPrice,
                    "additionalInfo" : info.additionalInfo,
                    "tosAgree" : info.tosAgree,
                    "providerType" : info.providerType,
                    "roomsImage" : info.roomsImage,
                    "isOnPublic" : info.isOnPublic,
                    "uploadTime" : Date()
                ])
                //TODO: Fetch new data when it's updated
                info = try await roomPath.getDocument(as: RoomPostDM.self)
            }
        case .external:
            let roomPath = db.collection(collectionType.rawValue)
            _  = try await roomPath.addDocument(data: [
                "roomSize" : info.roomSize,
                "roomAddress" : info.roomAddress,
                "rentalPrice" : info.rentalPrice,
                "additionalInfo" : info.additionalInfo,
                "tosAgree" : info.tosAgree,
                "providerType" : info.providerType,
                "roomsImage" : info.roomsImage,
                "providerInfo" : uid,
                "isOnPublic" : info.isOnPublic,
                "uploadTime" : Date()
            ])
        }
    }
    
    func fetchUploadRoom(
        uid: String,
        fetchData: inout [RoomPostDM],
        spot fetch: PostSpot
    ) async throws {
        collectionType = .rooms
        
        switch fetch {
        case .inside:
            let roomPath = db.collection(collectionType.rawValue).document(uid).collection(uid)
            let document = try await roomPath.getDocuments().documents
            fetchData = document.compactMap { queryDocumentSnapshot in
                let result = Result {
                    try queryDocumentSnapshot.data(as: RoomPostDM.self)
                }
                switch result {
                case .success(let success):
                    return success
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                return nil
            }
        case .external:
            let roomPath = db.collection(collectionType.rawValue)
            let document = try await roomPath.getDocuments().documents
            fetchData = document.compactMap { queryDocumentSnapshot in
                let result = Result {
                    try queryDocumentSnapshot.data(as: RoomPostDM.self)
                }
                switch result {
                case .success(let success):
                    return success
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
                return nil
            }
        }
        
    }
    
    //TODO: Create a remove process for publisher to remove the room that they uploaded
}
