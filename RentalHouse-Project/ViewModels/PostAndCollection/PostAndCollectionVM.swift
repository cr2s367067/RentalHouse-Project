//
//  PostAndCollectionVM.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/3.
//

import Foundation
import PhotosUI
import _PhotosUI_SwiftUI

protocol RoomsAction {
    func roomUpload(to spot: PostSpot) async throws
    func fetchPostedRoom(from spot: PostSpot) async throws
}

class PostAndCollectionVM: ObservableObject, RoomsAction {
    
    let fireDB = FirestoreDB()
    let fireAuth = FirebaseUserAuth()
    
    @Published var houseCollection = [RoomPostDM]()
    @Published var providerCollection = [RoomPostDM]()
    @Published var roomData: RoomPostDM = .empty
    
    func roomUpload(to spot: PostSpot) async throws {
        let uid = fireAuth.getUid()
        guard !uid.isEmpty else { return }
        try await fireDB.roomUploadProcess(
            uid: uid,
            room: roomData,
            spot: spot
        )
    }
    
    @MainActor
    func fetchPostedRoom(from spot: PostSpot) async throws {
        let uid = fireAuth.getUid()
        guard !uid.isEmpty else { return }
        try await fireDB.fetchUploadRoom(
            uid: uid,
            fetchData: &providerCollection,
            spot: spot
        )
    }
}

@available(iOS 16, *)
class PostAndCollectionVM_ios16: ObservableObject {
    @Published var test: PhotosPickerItem? = nil
}

