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
    @EnvironmentObject var pacVM: PostAndCollectionVM
    @StateObject var appVM = AppVM()
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Text("Setting")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.heavy)
            }
            .padding(.leading, 10)
            CustomNaviLink(
                sysImage: "person",
                labelTitle: "User",
                destination: UserDashboard()
            )
            .padding(.leading, 10)
            Group {
                if userAuth.userStatue == .provider {
                    CustomNaviLink(
                        sysImage: "square.and.pencil",
                        labelTitle: "Post",
                        destination: HousePostView().environmentObject(pacVM)
                    )
                    CustomNaviLink(
                        sysImage: "folder",
                        labelTitle: "Folder",
                        destination: PostCollectionView().environmentObject(pacVM)
                    )
                }
            }
            .padding(.leading, 10)
            Spacer()
            signOutButton()
                .padding(.leading, 10)
        }
        .padding()
        .background(alignment: .center) {
            Color("GeneralBackground")
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
                .font(.body)
                .fontWeight(.bold)
        }
        .frame(width: AppVM.uiScreenWidth * 0.2, height: AppVM.uiScreenHeight * 0.03, alignment: .center)
        .modifier(FlatGlass())
    }
}
