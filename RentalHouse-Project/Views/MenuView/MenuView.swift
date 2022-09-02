//
//  MenuView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var userAuth: UserAuthenticationVM
    @StateObject var appVM = AppVM()
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Setting")
                    .font(.title)
                    .fontWeight(.heavy)
            }
            NavigationLink {
                UserDashboard()
            } label: {
                Label("User", systemImage: "person")
                    .foregroundColor(.black)
                    .font(.title2)
            }
            if userAuth.userStatue == .provider {
                NavigationLink {
                } label: {
                    Label("Post", systemImage: "square.and.pencil")
                        .foregroundColor(.black)
                        .font(.title2)
                }
            }
            Spacer()
            signOutButton()
        }
        .padding()
        .background(alignment: .center) {
            LinearGradient(colors: [Color(appVM.randomGredientColor1), Color(appVM.randomGredientColor2)], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static let userAuth = UserAuthenticationVM()
    static var previews: some View {
        MenuView()
            .environmentObject(userAuth)
    }
}

extension MenuView {
    @ViewBuilder
    func signOutButton() -> some View {
        Button {
            //Sign out function
            userAuth.isSignIn = false
        } label: {
            Text("Sign Out")
                .foregroundColor(.red)
                .font(.title3)
                .fontWeight(.bold)
        }
        .frame(width: AppVM.uiScreenWidth * 0.2, height: AppVM.uiScreenHeight * 0.03, alignment: .center)
        .modifier(FlatGlass())
    }
}
