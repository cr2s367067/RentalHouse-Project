//
//  UserDM.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/4.
//

import Foundation


struct UserDM: Codable, Equatable {
    var nickName: String
    var signUpType: String
    var mobile: String
    var lineID: String
    var profileImagePath: String
    var accountVerificated: Bool
    var agreeTOSPolicy: Bool
}

extension UserDM {
    static let empty = UserDM(
        nickName: "",
        signUpType: "",
        mobile: "",
        lineID: "",
        profileImagePath: "",
        accountVerificated: false,
        agreeTOSPolicy: false
    )
    
    static func userIntoInit(signUpType: String, isRead: Bool) -> UserDM {
        return UserDM (
            nickName: "",
            signUpType: signUpType,
            mobile: "",
            lineID: "",
            profileImagePath: "",
            accountVerificated: false,
            agreeTOSPolicy: isRead
        )
    }
}
