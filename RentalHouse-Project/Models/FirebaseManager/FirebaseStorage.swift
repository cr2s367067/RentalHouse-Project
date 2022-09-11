//
//  FirebaseStorage.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/3.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift

class FireStorage {
    
    enum StoreagePath: String {
        case userProfile = "UserProfile"
        case roomsImage = "roomsImage"
    }
    let db = Firestore.firestore()
    let storageSourcePath = Storage.storage(url: "gs://sweethome-rentalhouse-project.appspot.com/")
    
    func uploadProcess(to path: StoreagePath, images: [UIImage], uid: String, roomUID: String? = "") async throws {
        switch path {
        case .userProfile:
            try await profileUploadProcess(to: path, images: images, uid: uid)
        case .roomsImage:
            guard let roomUID = roomUID else { return }
            try await roomsImageUploadProcess(to: path, images: images, uid: uid, roomUID: roomUID)
        }
    }
    
    func profileUploadProcess(to path: StoreagePath, images: [UIImage], uid: String) async throws {
        let storagePath = storageSourcePath.reference(withPath: path.rawValue)
        if let image = images.first ?? nil {
            guard let compressImage = image.jpegData(compressionQuality: 0.5) else { return }
            let imgUID = UUID().uuidString
            let imgRef = storagePath.child("\(imgUID).jpg")
            _ = try await imgRef.putDataAsync(compressImage)
            let userImagePath = try await imgRef.downloadURL().absoluteString
            let userPath = db.collection(CollectionType.users.rawValue).document(uid)
            try await userPath.updateData([
                "profileImagePath" : userImagePath
            ])
        }
    }
    
    func roomsImageUploadProcess(to path: StoreagePath, images: [UIImage], uid: String, roomUID: String) async throws {
        let storagePath = storageSourcePath.reference(withPath: path.rawValue)
        var roomImagesSet = [String]()
        for image in images {
            guard let compressImage = image.jpegData(compressionQuality: 0.5) else { return }
            let imgUID = UUID().uuidString
            let imgRef = storagePath.child("\(imgUID).jpg")
            _ = try await imgRef.putDataAsync(compressImage)
            let roomDownloadRef = try await imgRef.downloadURL().absoluteString
            roomImagesSet.append(roomDownloadRef)
        }
        let roomPath = db.collection(CollectionType.rooms.rawValue).document(roomUID)
        try await roomPath.updateData([
            "roomsImage" : roomImagesSet
        ])
    }
}
