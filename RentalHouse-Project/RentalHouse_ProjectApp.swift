//
//  RentalHouse_ProjectApp.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/27.
//

import SwiftUI

@main
struct RentalHouse_ProjectApp: App {
    
    @StateObject var userAuth = UserAuthenticationVM()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(userAuth)
            }
        }
    }
}
