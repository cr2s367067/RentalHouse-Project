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
        VStack {
            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Setting")
                        .foregroundColor(.white)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .padding(.leading, 5)
                CustomNaviLink(
                    sysImage: "person",
                    labelTitle: "User",
                    destination: UserDashboard()
                        .environmentObject(errorHandler)
                        .environmentObject(userAuth)
                )
                .padding(.leading, 5)
                Group {
                    if userAuth.userStatue == .provider {
                        CustomNaviLink(
                            sysImage: "square.and.pencil",
                            labelTitle: "Post",
                            destination: HousePostView()
                                .environmentObject(pacVM)
                                .environmentObject(errorHandler)
                        )
                        CustomNaviLink(
                            sysImage: "folder",
                            labelTitle: "Folder",
                            destination: PostCollectionView()
                                .environmentObject(pacVM)
                                .environmentObject(errorHandler)
                        )
                    }
                }
                .padding(.leading, 5)
                Spacer()
                signOutButton()
            }
        }
        .padding()
//        .frame(width: AppVM.uiScreenWidth * 0.5)
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
                .frame(width: AppVM.uiScreenWidth * 0.3, height: AppVM.uiScreenHeight * 0.1, alignment: .center)
        }
        .background {
            Color("SignOutButtonBackground")
                .offset(x: -5, y: 5)
                .frame(width: AppVM.uiScreenWidth * 0.3, height: AppVM.uiScreenHeight * 0.15)
                .edgesIgnoringSafeArea([.bottom, .leading])
        }
    }
}
