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
    func roomUpload(to spot: PostSpot, roomUID: String) async throws
    func roomImageUpload(roomUID: String) async throws
    func fetchPostedRoom(from spot: PostSpot) async throws
    
}

class PostAndCollectionVM: ObservableObject, RoomsAction {
    
    let fireStorage = FireStorage()
    let fireDB = FirestoreDB()
    let fireAuth = FirebaseUserAuth()
    
    @Published var selectedPhotos = [PhotosPickerItem]()
    
    @Published var houseCollection = [RoomPostDM]()
    @Published var providerCollection = [RoomPostDM]()
    @Published var roomData: RoomPostDM = .empty
    @Published var imageManager = [UIImage]()
    @Published var isProgressing = false
    @Published var isHouseOwner = false
    @Published var isHouseManager = false
    
    
    init() {
        #if DEBUG
        houseCollection = [.dummy]
        #endif
    }
    
    func restoreDefault() {
        roomData = .empty
        imageManager.removeAll()
        selectedPhotos.removeAll()
        isHouseOwner = false
        isHouseManager = false
    }
    
    @MainActor
    func roomCreateProcess() async throws {
        let roomUID = UUID().uuidString
        isProgressing = true
        try await roomUpload(to: .inside, roomUID: roomUID)
        try await roomImageUpload(roomUID: roomUID)
        restoreDefault()
        isProgressing = false
    }
    
    
    func roomUpload(to spot: PostSpot, roomUID: String) async throws {
        let uid = fireAuth.getUid()
        debugPrint("Get uid: \(uid)")
        guard !uid.isEmpty else { return }
        try await fireDB.roomUploadProcess(
            uid: uid,
            room: roomData,
            spot: spot,
            roomUID: roomUID
        )
    }
    
    func roomImageUpload(roomUID: String) async throws {
        let uid = fireAuth.getUid()
        try await fireStorage.uploadProcess(to: .roomsImage, images: imageManager, uid: uid, roomUID: roomUID)
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
    
    //FIX: providertype, and provider info doesn't input!!!
    func roomInfoBlankCheck() throws {
        guard !roomData.roomSize.isEmpty,
                !roomData.roomAddress.isEmpty,
                !roomData.rentalPrice.isEmpty,
                !roomData.additionalInfo.isEmpty,
                roomData.tosAgree != false,
                !roomData.providerType.isEmpty
        else {
            throw RoomPostError.infoEmpty
        }
              
    }
    
    
}

@available(iOS 16, *)
class PostAndCollectionVM_ios16: ObservableObject {
    @Published var selectedPhotos: [PhotosPickerItem]
//    @Published var imageManager = [UIImage]()
    
    init(selectedPhotos: [PhotosPickerItem]? = nil) {
        self.selectedPhotos = selectedPhotos ?? []
    }
}

