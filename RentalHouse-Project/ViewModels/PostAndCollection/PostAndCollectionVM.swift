//
//  PostAndCollectionVM.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/3.
//

import Foundation

class PostAndCollectionVM: ObservableObject {
    
    let fireDB = FirestoreDB()
    let fireAuth = FirebaseUserAuth()
    
    @Published var houseCollection = [RoomPostDM]()
    @Published var roomData: RoomPostDM = .empty
    
    func roomUpload() async throws {
        let uid = fireAuth.getUid()
        guard !uid.isEmpty else { return }
        try await fireDB.roomUploadProcess(uid: uid, room: roomData)
    }
    
}
