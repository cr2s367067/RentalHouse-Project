//
//  CustomComponent.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import Foundation
import SwiftUI

//MARK: - AuthTextField
struct AuthTextField: View {
    var fieldContain: Binding<String>
    var fieldName = ""
    var fieldType: LoginTextFieldType = .userName
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if fieldType == .userName {
                Text(fieldName)
                TextField("", text: fieldContain)
                    .textFieldStyle(.roundedBorder)
            } else {
                Text(fieldName)
                SecureField("", text: fieldContain)
                    .textFieldStyle(.roundedBorder)
            }
        }
        .padding()
        .frame(width: AppVM.uiScreenWidth * 0.9, height: AppVM.uiScreenHeight * 0.09, alignment: .center)
    }
}

//struct AuthTextField_preview: PreviewProvider {
//    static var previews: some View {
//        AuthTextField(fieldContain: .constant(""), fieldName: "Username", fieldType: .userName)
//    }
//}


//MARK: - Sign Up Button
struct SignUpUserButton: View {
    var isSelected = false
    var userType: SignUpUserType = .provider
    var buttonAct: (() -> Void)? = nil
    var body: some View {
        VStack {
            if userType == .provider {
                Button {
                    buttonAct?()
                } label: {
                    HStack {
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(isSelected ? .green : .black)
                        Text(userType.rawValue)
                            .foregroundColor(.primary)
                    }
                }
            } else {
                Button {
                    buttonAct?()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(isSelected ? .green : .black)
                        Text(userType.rawValue)
                            .foregroundColor(.primary)
                    }
                }
            }
        }
    }
}

//struct SignUpUserButton_preview: PreviewProvider {
//    static var previews: some View {
//        HStack {
//            SignUpUserButton(userType: .provider)
//        }
//    }
//}

//MARK: - Title and divider
struct TitleAndDivier: View {
    var title: String
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.title)
                .fontWeight(.heavy)
            Divider()
                .frame(width: AppVM.uiScreenWidth * 0.9)
                .foregroundColor(.black)
        }
    }
}


//struct TitleAndDivider_preview: PreviewProvider {
//    static var previews: some View {
//        TitleAndDivier(title: "Some Title")
//    }
//}
    
//MARK: - Search Bar
struct SearchBar: View {
    @Binding var input: String
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .lastTextBaseline, spacing: 5) {
                Image(systemName: "magnifyingglass")
                TextField("", text: $input)
                    .onTapGesture {
                        self.input = ""
                    }
            }
            .frame(width: AppVM.uiScreenWidth * 0.87, height: AppVM.uiScreenHeight * 0.02)
            .background(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.clear)
            }
            .modifier(FlatGlass())
        }
    }
}

//struct SearchBar_preview: PreviewProvider {
//    static var previews: some View {
//        SearchBar(input: .constant("some searching context"))
//    }
//}

//MARK: - Reuseabel card component
struct ReuseableCard: View {
    var objectName: String
    var objectPrice: String
    var body: some View {
        HStack {
            Image(systemName: "photo")
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                Text(objectName)
                Text("$\(objectPrice)")
                Spacer()
            }
            .frame(width: AppVM.uiScreenWidth * 0.5, height: AppVM.uiScreenHeight * 0.2, alignment: .center)
        }
        .padding()
        .frame(width: AppVM.uiScreenWidth * 0.87, height: AppVM.uiScreenHeight * 0.2, alignment: .center)
        .modifier(FlatGlass())
    }
}

//struct ReuseableCard_preview: PreviewProvider {
//    static var previews: some View {
//        ReuseableCard(objectName: "temp object", objectPrice: "500")
//    }
//}

//MARK: - Reuseable room infomation text field

enum InfoTextFieldType {
    case horizontal
    case vertical
}

struct ReuseableInfoTextField: View {
//    var widthPercentage: Double {
//        if layoutType == .horizontal {
//            return 0.5
//        }
//    }
//    var heightPercentage: Double
    private let colorOpacity = 0.08
    var fieldName: String
    var layoutType: InfoTextFieldType = .horizontal
    @Binding var input: String
    var body: some View {
        if layoutType == .horizontal {
            HStack {
                Text("\(fieldName):")
                TextField("", text: $input)
                    .textFieldStyle(.plain)
                    .background(.gray.opacity(colorOpacity))
            }
            .frame(width: AppVM.uiScreenWidth * 0.8, height: AppVM.uiScreenHeight * 0.02, alignment: .leading)
            .modifier(FlatGlass())
        } else {
            VStack(alignment: .leading, spacing: 4) {
                Text("\(fieldName):")
                TextField("", text: $input)
                    .textFieldStyle(.plain)
                    .background(.gray.opacity(colorOpacity))
            }
            .frame(width: AppVM.uiScreenWidth * 0.8, height: AppVM.uiScreenHeight * 0.05, alignment: .leading)
            .modifier(FlatGlass())
        }
    }
}

//struct ReuseableInfoTextField_preview: PreviewProvider {
//    static var previews: some View {
//        ReuseableInfoTextField(fieldName: "Room size", layoutType: .vertical, input: .constant("10"))
//    }
//}


//MARK: - Reuseable confirm check box
struct ReuseableCofirmCheckBoxWithStatement: View {
    var statement: String
    var isAgree = false
    var agreeFunc: (() -> Void)? = nil
    var body: some View {
        HStack(spacing: 5) {
            Button {
                agreeFunc?()
            } label: {
                Image(systemName: isAgree ? "checkmark.square.fill" : "square")
                    .foregroundColor(isAgree ? .green : .gray)
                    .font(.headline)
            }
            Text(statement)
                .font(.headline)
                .fontWeight(.bold)
        }
    }
}

//struct ReuseableCofirmCheckBoxWithStatement_preview: PreviewProvider {
//    static var previews: some View {
//        ReuseableCofirmCheckBoxWithStatement(statement: "Test statement", isAgree: false, agreeFunc: nil)
//    }
//}

//MARK: - Reuseable room card
struct ReuseableRoomItemCard: View {
    var roomData: RoomPostDM = .empty
    var body: some View {
        HStack {
            Image(systemName: "photo")
                .frame(width: AppVM.uiScreenWidth * 0.3, height: AppVM.uiScreenHeight * 0.14, alignment: .center)
                .background(alignment: .center) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.brown.opacity(0.3))
                }
            VStack(alignment: .leading, spacing: 15) {
                Text(roomData.roomAddress)
                Text("Size: \(roomData.roomSize)")
                Text("Monthly Fee: \(roomData.rentalPrice)")
            }
            .font(.headline)
            .frame(width: AppVM.uiScreenWidth * 0.5, height: AppVM.uiScreenHeight * 0.14, alignment: .topLeading)
        }
        .frame(width: AppVM.uiScreenWidth * 0.87, height: AppVM.uiScreenHeight * 0.21, alignment: .center)
        .modifier(FlatGlass())
    }
}

//struct ReuseableRoomItemCard_preview: PreviewProvider {
//    static var previews: some View {
//        ReuseableRoomItemCard()
//    }
//}

//MARK: - Custom navigate menu item
struct CustomNaviLink<Destination: View>: View {
    var sysImage: String
    var labelTitle: String
    var destination: Destination
    var body: some View {
        NavigationLink {
            destination
        } label: {
            Label(labelTitle, systemImage: sysImage)
                .foregroundColor(.black)
                .font(.title2)
        }
    }
}

//MARK: - SignIn/SignUp button
struct ReuseableAuthButton: View {
    var buttonName: String
    var taskFunction: (()->Void)? = nil
    var body: some View {
        Button {
            taskFunction?()
        } label: {
            Text(buttonName)
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
}

