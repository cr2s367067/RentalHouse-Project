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
}

extension UserDM {
    static let empty = UserDM(
        nickName: "",
        signUpType: "",
        mobile: "",
        lineID: "",
        profileImagePath: ""
    )
    
    static func userIntoInit(signUpType: String) -> UserDM {
        return UserDM (
            nickName: "",
            signUpType: signUpType,
            mobile: "",
            lineID: "",
            profileImagePath: ""
        )
    }
}
