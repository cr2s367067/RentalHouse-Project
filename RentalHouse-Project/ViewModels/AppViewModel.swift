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
    }
    
    init() {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    static let uiScreenWidth = UIScreen.main.bounds.width
    static let uiScreenHeight = UIScreen.main.bounds.height
    
    @Published var randomGredientColor1 = "Gredient1"
    @Published var randomGredientColor2 = "Gredient2"
    
    static func isSame<T: Equatable>(lhs: T, rhs: T) -> Bool {
        return lhs == rhs
    }

}
