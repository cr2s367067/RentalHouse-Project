//
//  RoomPostDM.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import Foundation


struct RoomPostDM: Identifiable, Codable {
    var id = UUID().uuidString
    var roomSize: String
    var roomAddress: String
    var rentalPrice: String
    var additionalInfo: String
    var tosAgree: Bool
}

extension RoomPostDM {
    static let empty = RoomPostDM(
        roomSize: "",
        roomAddress: "",
        rentalPrice: "",
        additionalInfo: "",
        tosAgree: false
    )
}
