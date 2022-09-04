//
//  MenuView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import SwiftUI

struct MenuView: View {
    @EnvironmentObject var userAuth: UserAuthenticationVM
    @EnvironmentObject var errorHandler: ErrorHandler
    @StateObject var appVM = AppVM()
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Setting")
                    .font(.title)
                    .fontWeight(.heavy)
            }
            CustomNaviLink(
                sysImage: "person",
                labelTitle: "User",
                destination: UserDashboard()
            )
            if userAuth.userStatue == .provider {
                CustomNaviLink(sysImage: "square.and.pencil", labelTitle: "Post", destination: HousePostView())
                CustomNaviLink(sysImage: "folder", labelTitle: "Folder", destination: PostCollectionView())
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
            do {
                try userAuth.userSignOut()
            } catch {
                errorHandler.handler(error: error)
            }
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
