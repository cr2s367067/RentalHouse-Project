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
    var roomCoverImage: String
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
        roomCoverImage: ""
    )
}
