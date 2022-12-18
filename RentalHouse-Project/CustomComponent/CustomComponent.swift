//
//  CustomComponent.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

//MARK: - AuthTextField
struct AuthTextField: View {
    private let holderTextColorOpacity = 0.7
    var fieldContain: Binding<String>
    var fieldName = ""
    var fieldType: LoginTextFieldType = .userName
    var hasContain: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            if fieldType == .userName {
                TextField("", text: fieldContain)
                    .placeholder(when: hasContain) {
                        Text(fieldName)
                            .foregroundColor(.white.opacity(holderTextColorOpacity))
                    }
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(.emailAddress)
                    .modifier(TextFieldModifier())
            } else {
                SecureField("", text: fieldContain)
                    .placeholder(when: hasContain) {
                        Text(fieldName)
                            .foregroundColor(.white.opacity(holderTextColorOpacity))
                    }
                    .disableAutocorrection(true)
                    .textInputAutocapitalization(.never)
                    .keyboardType(.default)
                    .modifier(TextFieldModifier())
            }
        }
    }
}

//struct AuthTextField_preview: PreviewProvider {
//    static var previews: some View {
//        AuthTextField(fieldContain: .constant(""), fieldName: "Username", fieldType: .userName, hasContain: false)
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
                            .foregroundColor(isSelected ? .green : .white)
                        Text(userType.rawValue)
                            .foregroundColor(.white)
                    }
                }
            } else {
                Button {
                    buttonAct?()
                } label: {
                    HStack(spacing: 5) {
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(isSelected ? .green : .white)
                        Text(userType.rawValue)
                            .foregroundColor(.white)
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

//MARK: - Post view room info text field
struct CustomTextFieldWithName: View {
    var title: String
    @Binding var infoContain: String
    var summitCheck: Bool
    var showCautionBorder: Bool
    var fieldName: String
    var hasContain: Bool
    var fieldType: AppVM.TextFieldType = .normal
    @State private var isSecure = true
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack(spacing: (AppVM.uiScreenHeight / 6) * 0.1) {
            HStack {
                Text(title)
                    .foregroundColor(Color("TextFieldContainColor"))
                    .font(Font.custom("SFPro-Regular", size: 14))
                Spacer()
            }
            ZStack {
                if fieldType == .normal {
                    TextField("", text: $infoContain)
                        .placeholder(when: hasContain) {
                            Text(fieldName)
                                .foregroundColor(Color(AppVM.ColorSet.textFieldPlaceHolder.rawValue))
                                .font(Font.custom("SFPro-Regular", size: 14))
                        }
                        .foregroundColor(Color("TextFieldContainColor"))
                        .frame(height: (AppVM.uiScreenHeight / 4) * 0.24)
                        .cornerRadius(10)
                        .background {
                            Color(AppVM.ColorSet.textFieldBackground.rawValue)
                                .cornerRadius(10)
                                .border(summitCheck ? showCautionBorder ? Color(AppVM.ColorSet.cautionTextColor.rawValue) : Color(AppVM.ColorSet.isSelectedButtonBackground.rawValue) : Color(AppVM.ColorSet.isSelectedButtonBackground.rawValue))
                        }
                }
                if fieldType == .secure {
                    if isSecure {
                        SecureField("", text: $infoContain)
                            .placeholder(when: hasContain) {
                                Text(fieldName)
                                    .foregroundColor(Color(AppVM.ColorSet.textFieldPlaceHolder.rawValue))
                                    .font(Font.custom("SFPro-Regular", size: 14))
                            }
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.default)
                            .foregroundColor(Color("TextFieldContainColor"))
                            .frame(height: (AppVM.uiScreenHeight / 4) * 0.24)
                            .cornerRadius(10)
                            .background {
                                Color(AppVM.ColorSet.textFieldBackground.rawValue)
                                    .cornerRadius(10)
                                    .border(summitCheck ? showCautionBorder ? Color(AppVM.ColorSet.cautionTextColor.rawValue) : Color(AppVM.ColorSet.isSelectedButtonBackground.rawValue) : Color(AppVM.ColorSet.isSelectedButtonBackground.rawValue))
                            }
                    } else {
                        TextField("", text: $infoContain)
                            .foregroundColor(Color("TextFieldContainColor"))
                            .frame(height: (AppVM.uiScreenHeight / 4) * 0.24)
                            .cornerRadius(10)
                            .placeholder(when: hasContain) {
                                Text(fieldName)
                                    .foregroundColor(Color(AppVM.ColorSet.textFieldPlaceHolder.rawValue))
                                    .font(Font.custom("SFPro-Regular", size: 14))
                            }
                            .disableAutocorrection(true)
                            .textInputAutocapitalization(.never)
                            .keyboardType(.default)
                            .background {
                                Color(AppVM.ColorSet.textFieldBackground.rawValue)
                                    .cornerRadius(10)
                                    .border(summitCheck ? showCautionBorder ? Color(AppVM.ColorSet.cautionTextColor.rawValue) : Color(AppVM.ColorSet.isSelectedButtonBackground.rawValue) : Color(AppVM.ColorSet.isSelectedButtonBackground.rawValue))
                            }
                    }
                }
                HStack(spacing: (AppVM.uiScreenWidth / 4) * 0.1) {
                    Spacer()
                    if infoContain.count > 0 {
                        Button {
                            infoContain.removeAll()
                        } label: {
                            Image(colorScheme == .dark ? "DarkCloseButton" : "LightCloseButton")
                        }
                        if fieldType == .secure {
                            Button {
                                withAnimation {
                                    isSecure.toggle()
                                }
                            } label: {
                                Image(isSecure ?  colorScheme == .dark ? "DarkCloseEye" : "LightCloseEye" : colorScheme == .dark ? "DarkOpenEye" : "LightOpenEye")
                            }
                        }
                    }
                }
                .padding(.trailing, (AppVM.uiScreenWidth / 4) * 0.25)
            }
        }
        .frame(width:  AppVM.uiScreenWidth * 0.97)
    }
}

struct CustomTextFieldWithName_preview: PreviewProvider {
    static var previews: some View {
        CustomTextFieldWithName(title: "Text", infoContain: .constant(""), summitCheck: false, showCautionBorder: false, fieldName: "placeholder", hasContain: false)
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
                    .foregroundColor(.white.opacity(0.5))
                TextField("", text: $input)
                    .foregroundColor(.white)
                    .onTapGesture {
                        self.input = ""
                    }
            }
            .frame(width: AppVM.uiScreenWidth * 0.75, height: AppVM.uiScreenHeight * 0.02)
            .background(alignment: .center) {
                RoundedRectangle(cornerRadius: 5)
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
    var roomAddress: String
    var roomIntro: String
    var roomPrice: String
    var roomsImage: [String]
    var body: some View {
        HStack {
//            WebImage(url: URL(string: roomsImage.randomElement() ?? ""))
            Image("room")
                .resizable()
//                .scaledToFit()
                .frame(width: AppVM.uiScreenWidth * 0.44, height: AppVM.uiScreenHeight * 0.18, alignment: .center)
            Spacer()
            VStack(alignment: .leading, spacing: 10) {
                Text(roomAddress)
                Text(roomIntro)
                    .frame(minHeight: AppVM.uiScreenHeight * 0.05, maxHeight: AppVM.uiScreenHeight * 0.1)
                Text("$\(roomPrice)/月")
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.black.opacity(0.35))
                            .frame(minWidth: AppVM.uiScreenWidth * 0.2, minHeight: AppVM.uiScreenHeight * 0.035)
                    }
                Spacer()
            }
            .foregroundColor(.white)
            .padding()
            .frame(width: AppVM.uiScreenWidth * 0.5, height: AppVM.uiScreenHeight * 0.2, alignment: .leading)
        }
        .padding()
        .frame(width: AppVM.uiScreenWidth, height: AppVM.uiScreenHeight * 0.2, alignment: .center)
        .background(alignment: .center) {
            Color.gray.opacity(0.9)
        }
    }
}

//struct ReuseableCard_preview: PreviewProvider {
//    static var previews: some View {
//        ReuseableCard(roomAddress: "Temp name", roomIntro: "dunnu addressdunnu addressdunnu addressdunnu address", roomPrice: "1000", roomsImage: .init())
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
                .foregroundColor(.white)
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
            if roomData.roomsImage.count > 1 {
                WebImage(url: URL(string: getFirstCoverImage(roomData: roomData)))
                    .resizable()
                    .frame(width: AppVM.uiScreenWidth * 0.3, height: AppVM.uiScreenHeight * 0.14, alignment: .center)
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            } else {
                Image(systemName: "photo")
                    .frame(width: AppVM.uiScreenWidth * 0.3, height: AppVM.uiScreenHeight * 0.14, alignment: .center)
                    .background(alignment: .center) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.brown.opacity(0.3))
                    }
            }
            VStack(alignment: .leading, spacing: 15) {
                Text(roomData.roomAddress)
                Text("Size: \(roomData.roomSize)")
                Text("Monthly Fee: \(roomData.rentalPrice)")
            }
            .foregroundColor(.white)
            .font(.headline)
            .frame(width: AppVM.uiScreenWidth * 0.5, height: AppVM.uiScreenHeight * 0.1, alignment: .topLeading)
        }
        .frame(width: AppVM.uiScreenWidth * 0.87, height: AppVM.uiScreenHeight * 0.13, alignment: .center)
        .modifier(FlatGlass())
    }
}

extension ReuseableRoomItemCard {
    func getFirstCoverImage(roomData: RoomPostDM) -> String {
        if roomData.roomsImage.count > 1 {
            return roomData.roomsImage.first ?? ""
        }
        return ""
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
                .foregroundColor(.white)
                .font(.body)
        }
    }
}

//MARK: - SignIn/SignUp button
struct ReuseableLargeButton: View {
    var buttonName: String
    var isDarkGreen = true
    var buttonWidth = AppVM.uiScreenWidth * 0.97
    var buttonHeight = AppVM.uiScreenHeight * 0.05
    var taskFunction: (()->Void)? = nil
    var body: some View {
        Button {
            taskFunction?()
        } label: {
            Text(buttonName)
                .foregroundColor(Color(isDarkGreen ? AppVM.ColorSet.unSelectedButtonTextColor.rawValue : AppVM.ColorSet.isSelectedButtonTextColor.rawValue))
                .font(.custom("SFPro-Regular", size: 15))
                .frame(width: buttonWidth, height: buttonHeight, alignment: .center)
        }
        .background {
            Color(isDarkGreen ? AppVM.ColorSet.isSelectedButtonBackground.rawValue : AppVM.ColorSet.unSelectedButtonBackground.rawValue)
                .cornerRadius(4)
        }
    }
}

//MARK: - Side bar menu
struct SideMenuBar<SidebarContent: View, Content: View>: View {
    let sidebarContent: SidebarContent
    let mainContent: Content
    let sidebarWidth: CGFloat
    @Binding var showSidebar: Bool
    
    init(
        sidebarWidth: CGFloat,
        showSidebar: Binding<Bool>,
        @ViewBuilder sidebar: () -> SidebarContent,
        @ViewBuilder content: () -> Content
    ) {
        self.sidebarWidth = sidebarWidth
        _showSidebar = showSidebar
        sidebarContent = sidebar()
        mainContent = content()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            mainContent
                .overlay(
                    Group {
                        if showSidebar {
                            Color.black.opacity(0.8)
                                .edgesIgnoringSafeArea([.top, .bottom])
                                .onTapGesture {
                                    withAnimation {
                                        self.showSidebar = false
                                    }
                                }
                                .animation(.easeInOut, value: 2)
                        }
                    }, alignment: .center
                )
                .animation(.easeInOut, value: 2)
            sidebarContent
                .frame(width: sidebarWidth, alignment: .leading)
                .offset(x: showSidebar ? 0 : -1 * sidebarWidth, y: 0)
                .animation(.easeInOut, value: 2)
        }
    }
}

//MARK: - Reuseable Button - Provider Type
enum ProviderType: String {
    case houseOwner = "Owner"
    case rentalManager = "Manager"
}

struct ReuseableButtonProviderType: View {
    var buttonName: ProviderType = .houseOwner
    var isSelected: Bool
    var buttonAction: (()->Void)? = nil
    var body: some View {
        HStack {
            Button {
                buttonAction?()
            } label: {
                HStack(spacing: 5) {
                    Image(systemName: isSelected ? "checkmark.square.fill" : "square")
                        .foregroundColor(isSelected ? .green : .gray)
                    Text(buttonName.rawValue)
                        .foregroundColor(.white)
                        .font(.body)
                        .fontWeight(.bold)
                }
            }
        }
        .modifier(FlatGlass())
    }
}

//struct ReuseableButtonProviderType_preview: PreviewProvider {
//    static var previews: some View {
//        ReuseableButtonProviderType(isSelected: false)
//    }
//}

//MARK: - PageStyle scroll view
struct PageHorizontalScrollView: View {
    
    var imageSet: [String]?

    var body: some View {
        if let imageSet = imageSet {
            TabView {
                ForEach(imageSet, id: \.self) { img in
                    if let url = URL(string: img) {
                        WebImage(url: url)
                            .resizable()
                            .scaledToFit()
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            .frame(width: AppVM.uiScreenWidth * 0.9, height: AppVM.uiScreenHeight * 0.3)
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
        }
    }
    
}


//MARK: - Reuseable Button

struct ReuseableButton: View {
    var buttonToggle: Bool
    var buttonTitle: String
    var width = (AppVM.uiScreenWidth / 2) * 0.8
    var height = (AppVM.uiScreenHeight / 4) * 0.2
    var buttonImagePosition: AppVM.ButtonImagePositionConfig = .none
    var action: (()->Void)? = nil
    var body: some View {
        Button {
            action?()
        } label: {
            switch buttonImagePosition {
            case .imageLeft:
                HStack(spacing: 5) {
                    Image(systemName: "photo")
                    Text(buttonTitle)
                        .foregroundColor(Color(buttonToggle ? AppVM.ColorSet.unSelectedButtonTextColor.rawValue : AppVM.ColorSet.isSelectedButtonTextColor.rawValue))
                }
                .frame(width: width, height: height)
            case .imageRight:
                HStack(spacing: 5) {
                    Text(buttonTitle)
                        .foregroundColor(Color(buttonToggle ? AppVM.ColorSet.unSelectedButtonTextColor.rawValue : AppVM.ColorSet.isSelectedButtonTextColor.rawValue))
                    Image(systemName: "photo")
                }
                .frame(width: width, height: height)
            case .none:
                Text(buttonTitle)
                    .foregroundColor(Color(buttonToggle ? AppVM.ColorSet.unSelectedButtonTextColor.rawValue : AppVM.ColorSet.isSelectedButtonTextColor.rawValue))
                    .frame(width: width, height: height)
            }
        }
        .background {
            Color(buttonToggle ? AppVM.ColorSet.isSelectedButtonBackground.rawValue : AppVM.ColorSet.unSelectedButtonBackground.rawValue)
                .cornerRadius(4)
        }
    }
}

//struct ReuseableButton_Provider: PreviewProvider {
//    static var previews: some View {
//        ReuseableButton(buttonToggle: false)
//    }
//}
