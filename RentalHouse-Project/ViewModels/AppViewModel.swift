//
//  AppViewModel.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/27.
//

import Foundation
import UIKit

class AppVM: ObservableObject {
    
    static let shared = AppVM()
    
    enum NanigationTitles: String {
        case postPage = "Post"
        case userPage = "User Profile"
        case roomCollection = "Room Collection"
     }
    
    enum NavigationLocate {
        case isLocal, isPublic
    }
    
    enum TextFieldType {
        case normal
        case secure
        
    }
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    static let uiScreenWidth = UIScreen.main.bounds.width
    static let uiScreenHeight = UIScreen.main.bounds.height
    static var navigationLocate: NavigationLocate = .isLocal
    
    @Published var randomGredientColor1 = "Gredient1"
    @Published var randomGredientColor2 = "Gredient2"
    
    static func isSame<T: Equatable>(lhs: T, rhs: T) -> Bool {
        return lhs == rhs
    }

}


extension AppVM {
    enum ColorSet: String {
        case isSelectedButtonBackground = "IsSelectedButtonColor"
        case unSelectedButtonBackground = "UnSelectedButtonColor"
        case isSelectedButtonTextColor = "IsSelectedButtonTextColor"
        case unSelectedButtonTextColor = "UnSelectedButtonTextColor"
        case textFieldContainColor = "TextFieldContainColor"
        case textFieldPlaceHolder = "TextFieldPlaceHolder"
        case textFieldBackground = "TextFieldBackground"
        case lightTextGray = "LightTextGray"
        case lightSpecialStyle2 = "LightSpecialStyle2"
        case cautionTextColor = "CautionTextColor"
    }
    
    enum ButtonImagePositionConfig {
        case imageLeft, imageRight, none
    }
    
    enum ButtonHeightConfig {
        case type1, type2
    }
    
    enum SignUpStatus {
        case userSelectionView, infoFieldView, authenticationView
    }
    
    enum ForgetPasswordStatus {
        case recoveryEmailView, authenticationView, resetPassswordView
    }
    
}
