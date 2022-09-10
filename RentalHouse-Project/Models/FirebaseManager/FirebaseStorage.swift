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
    
    func uploadProcess(to path: StoreagePath, images: [UIImage], uid: String) async throws {
        let storagePath = storageSourcePath.reference(withPath: path.rawValue)
        for image in images {
            guard let compressImage = image.jpegData(compressionQuality: 0.5) else { return }
            let imgUID = UUID().uuidString
            let imgRef = storagePath.child("\(imgUID).jpg")
            _ = try await imgRef.putDataAsync(compressImage)
            switch path {
            case .userProfile:
                let userImagePath = try await imgRef.downloadURL().absoluteString
                let userPath = db.collection(CollectionType.users.rawValue).document(uid)
                try await userPath.updateData([
                    "profileImagePath" : userImagePath
                ])
            case .roomsImage:
                continue
            }
        }
    }
}
