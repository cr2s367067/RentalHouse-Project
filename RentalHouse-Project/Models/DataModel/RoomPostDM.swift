//
//  RoomPostDM.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct RoomPostDM: Identifiable, Codable {
    @DocumentID var id: String?
    var roomSize: String
    var roomAddress: String
    var rentalPrice: String
    var additionalInfo: String
    var tosAgree: Bool
    var providerType: String
    var roomsImage: [String]
    var providerInfo: String
    var isOnPublic: Bool
    @ServerTimestamp var uploadTime: Timestamp?
}

extension RoomPostDM {
    static let empty = RoomPostDM(
        roomSize: "",
        roomAddress: "",
        rentalPrice: "",
        additionalInfo: "",
        tosAgree: false,
        providerType: "",
        roomsImage: [],
        providerInfo: "",
        isOnPublic: false
    )
    
    static let dummy = RoomPostDM(
        roomSize: "12",
        roomAddress: "114 temp address",
        rentalPrice: "4200",
        additionalInfo: "none",
        tosAgree: true,
        providerType: "RentalManager",
        roomsImage: ["cover image address"],
        providerInfo: "provider uid",
        isOnPublic: false
    )
}
