//
//  UserDashboard.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import SwiftUI

struct UserDashboard: View {
    var body: some View {
        VStack {
            TitleAndDivier(title: "User Dashboard")
            userHeader()
            editButton()
            userDetailComponent(mobile: "", line: "")
            Spacer()
            signOutButton()
        }
        .modifier(ViewBackground())
    }
}

struct UserDashboard_Previews: PreviewProvider {
    static var previews: some View {
        UserDashboard()
    }
}


extension UserDashboard {
    @ViewBuilder
    func userHeader() -> some View {
        HStack(spacing: 10) {
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
    
    @ViewBuilder
    func signOutButton() -> some View {
        Button {
            //Sign out function
        } label: {
            Text("Sign Out")
                .foregroundColor(.red)
                .font(.title3)
                .fontWeight(.bold)
        }
        .frame(width: AppVM.uiScreenWidth * 0.87, height: AppVM.uiScreenHeight * 0.03, alignment: .center)
        .modifier(FlatGlass())
    }
    
    @ViewBuilder
    func editButton() -> some View {
        HStack {
            Spacer()
            Button("Edit") {
                //Edit toggle
            }
        }
    }
}
