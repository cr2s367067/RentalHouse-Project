//
//  UserDashboard.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import SwiftUI

struct UserDashboard: View {
    
    enum NavigationButtonStatus {
        case isNotEditing, isEditing
    }
    
    @EnvironmentObject var userAuthVM: UserAuthenticationVM
    @EnvironmentObject var errorHandler: ErrorHandler
    @State private var isEditMode = false
    
    @State private var navButtonStatus: NavigationButtonStatus = .isNotEditing
    
    var body: some View {
        VStack {
            VStack {
                modePresenter()
            }
            .frame(width: AppVM.uiScreenWidth, height: AppVM.uiScreenHeight * 0.85)
            .background {
                Color("ContainBackground")
                    .offset(y: AppVM.uiScreenHeight * 0.08)
                    .frame(width: AppVM.uiScreenWidth, height: AppVM.uiScreenHeight)
                    .edgesIgnoringSafeArea([.bottom])
            }
        }
        .modifier(ViewBackground(backgroundType: .generalBackground, navigationTitle: AppVM.NanigationTitles.userPage.rawValue))
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation {                    
                        isEditMode.toggle()
                        editEvaluate(isEdit: isEditMode)
                    }
                } label: {
                    switch navButtonStatus {
                    case .isNotEditing:
                        Image(systemName: "gearshape.2")
                            .foregroundColor(.white)
                            .font(.body)
                    case .isEditing:
                        Text("Done")
                            .foregroundColor(.blue)
                            .font(.body)
                    }
                }
            }
        }
    }
}

struct UserDashboard_Previews: PreviewProvider {
    static let userAuthVM = UserAuthenticationVM()
    static var previews: some View {
        UserDashboard()
            .environmentObject(userAuthVM)
    }
}

//MARK: - View extent
extension UserDashboard {
    @ViewBuilder
    func modePresenter() -> some View {
        if isEditMode {
            editMode()
        } else {
            presentMode()
        }
    }
    
    @ViewBuilder
    func presentMode() -> some View {
        VStack {
            userInfoPresenter(title: UserDashboardContainTitle.nickName.rawValue, contain: userAuthVM.user.nickName)
            userInfoPresenter(title: UserDashboardContainTitle.mobileNum.rawValue, contain: userAuthVM.user.mobile)
            userInfoPresenter(title: UserDashboardContainTitle.lineID.rawValue, contain: userAuthVM.user.lineID)
            Spacer()
        }
        .padding(.horizontal)
        .frame(width: AppVM.uiScreenWidth, height: AppVM.uiScreenHeight * 0.8)
        .background {
            Color("ContainBackground")
        }
    }
    
    
    @ViewBuilder
    func editMode() -> some View {
        VStack {
            CustomTextFieldWithName(title: UserDashboardContainTitle.nickName.rawValue, infoContain: $userAuthVM.user.nickName, fieldName: "Enter you nick name", hasContain: userAuthVM.user.nickName.isEmpty)
            CustomTextFieldWithName(title: UserDashboardContainTitle.mobileNum.rawValue, infoContain: $userAuthVM.user.mobile, fieldName: "Enter mobile number, if need", hasContain: userAuthVM.user.mobile.isEmpty)
            CustomTextFieldWithName(title: UserDashboardContainTitle.lineID.rawValue, infoContain: $userAuthVM.user.lineID, fieldName: "Enter line id, if need", hasContain: userAuthVM.user.lineID.isEmpty)
            Spacer()
        }
        .padding(.horizontal)
        .frame(width: AppVM.uiScreenWidth, height: AppVM.uiScreenHeight * 0.8)
        .background {
            Color("ContainBackground")
        }
    }
    
    
    @ViewBuilder
    func userInfoPresenter(title: String, contain: String) -> some View {
        VStack {
            HStack {
                Text(title)
                    .foregroundColor(.white)
                Spacer()
            }
            HStack {
                Text(contain)
                Spacer()
            }
            .foregroundColor(.white)
            Divider()
                .background(.white.opacity(0.5))
                .frame(height: 2)
        }
    }
    
    @ViewBuilder
    func userHeader() -> some View {
        HStack(spacing: 10) {
            //Overlay user profile, if it's exist
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(width: AppVM.uiScreenWidth * 0.24, height: AppVM.uiScreenHeight * 0.1, alignment: .center)
            Text("username")
                .font(.title3)
                .fontWeight(.bold)
            Spacer()
        }
        .frame(width: AppVM.uiScreenWidth * 0.87, height: AppVM.uiScreenHeight * 0.1, alignment: .center)
        .modifier(FlatGlass())
    }
    
    @ViewBuilder
    func userDetailComponent(
        mobile number: String,
        line id: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Group {
                HStack {
                    Text("Mobile Number: ")
                    Text(number)
                }
                HStack {
                    Text("Line ID:")
                    Text(id)
                }
            }
            .modifier(FlatGlass())
            Spacer()
        }
        .frame(width: AppVM.uiScreenWidth * 0.87, height: AppVM.uiScreenHeight * 0.3, alignment: .leading)
    }
}

extension UserDashboard {
    
    private func editEvaluate(isEdit: Bool) {
        if isEdit {
            navButtonStatus = .isEditing
            debugPrint("Is editing mode")
            userAuthVM.storUserInfoInTemp()
        } else {
            navButtonStatus = .isNotEditing
            debugPrint("Is not editing mode, info will updating")
            Task {
                do {
                    try await userAuthVM.userUpdate()
                } catch {
                    errorHandler.handler(error: error)
                }
            }
        }
    }
    
}
