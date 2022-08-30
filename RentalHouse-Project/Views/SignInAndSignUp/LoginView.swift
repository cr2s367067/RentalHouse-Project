//
//  LoginView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/27.
//

import Foundation
import SwiftUI


struct LoginView: View {
    
    @EnvironmentObject var userAuth: UserAuthenticationVM
    @EnvironmentObject var appVM: AppVM
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                NavigationLink("Sign up") {
                    SignUpView()
                        .environmentObject(userAuth)
                }
                .foregroundColor(.blue)
            }
            VStack(alignment: .center, spacing: 5) {
                HStack {
                    Text("Sign In")
                        .font(.title)
                        .fontWeight(.heavy)
                    Spacer()
                }
                AuthTextField(fieldContain: $userAuth.userName, fieldName: "Username", fieldType: .userName)
                AuthTextField(fieldContain: $userAuth.password, fieldName: "Password", fieldType: .password)
            }
            .modifier(FlatGlass())
            Button {
                userAuth.isSignIn = true
            } label: {
                Text("Sign In")
                    .font(.body)
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
            }
            .frame(width: AppVM.uiScreenWidth * 0.5, height: AppVM.uiScreenHeight * 0.05, alignment: .center)
            .background(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.cyan.opacity(0.3))
            }
            
        }
        .modifier(ViewBackground())
//        .padding()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(alignment: .center) {
//            LinearGradient(colors: [Color(appVM.randomGredientColor1), Color(appVM.randomGredientColor2)], startPoint: .topLeading, endPoint: .bottomTrailing)
//                .edgesIgnoringSafeArea([.top, .bottom])
//        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static let userAuth = UserAuthenticationVM()
    static let appVM = AppVM()
    static var previews: some View {
        LoginView()
            .environmentObject(userAuth)
            .environmentObject(appVM)
    }
}
