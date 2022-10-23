//
//  CustomMenuView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/10/15.
//

import SwiftUI

struct CustomMenuView: View {
    @EnvironmentObject var userAuth: UserAuthenticationVM
    @EnvironmentObject var errorHandler: ErrorHandler
    @EnvironmentObject var pacVM: PostAndCollectionVM
    @StateObject var appVM = AppVM()
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Setting")
                    .foregroundColor(.white)
                    .font(.title3)
                    .fontWeight(.bold)
                Spacer()
            }
            .padding(.leading, (AppVM.uiScreenWidth / 4) * 0.3)
            HStack {
                CustomNaviLink(
                    sysImage: "person",
                    labelTitle: "User",
                    destination: UserDashboard()
                        .environmentObject(errorHandler)
                        .environmentObject(userAuth)
                )
                Spacer()
            }
            .padding(.leading, (AppVM.uiScreenWidth / 4) * 0.3)
            Group {
                if userAuth.userStatue == .provider {
                    HStack {
                        CustomNaviLink(
                            sysImage: "square.and.pencil",
                            labelTitle: "Post",
                            destination: HousePostView()
                                .environmentObject(pacVM)
                                .environmentObject(errorHandler)
                        )
                        Spacer()
                    }
                    HStack {
                        CustomNaviLink(
                            sysImage: "folder",
                            labelTitle: "Folder",
                            destination: PostCollectionView()
                                .environmentObject(pacVM)
                                .environmentObject(errorHandler)
                        )
                        Spacer()
                    }
                }
            }
            .padding(.leading, (AppVM.uiScreenWidth / 4) * 0.3)
            Spacer()
            HStack {
                signOutButton()
                Spacer()
            }
            .background {
                Color("SignOutButtonBackground")
                    .edgesIgnoringSafeArea([.bottom, .leading, .trailing])
            }
        }
        .frame(maxWidth: .infinity)
        .background {
            Color("GeneralBackground")
                .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

struct CustomMenuView_Previews: PreviewProvider {
    static let userAuth = UserAuthenticationVM()
    static var previews: some View {
        CustomMenuView()
            .environmentObject(userAuth)
    }
}

extension CustomMenuView {
    @ViewBuilder
    func signOutButton() -> some View {
        Button {
            do {
                try userAuth.userSignOut()
            } catch {
                errorHandler.handler(error: error)
            }
        } label: {
            Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                .foregroundColor(.white)
                .font(.body)
                .frame(height: (AppVM.uiScreenHeight / 4) * 0.2)
                .frame(maxWidth: .infinity)
//                .frame(width: AppVM.uiScreenWidth * 0.5, height: AppVM.uiScreenHeight * 0.1, alignment: .center)
        }
    }
}
