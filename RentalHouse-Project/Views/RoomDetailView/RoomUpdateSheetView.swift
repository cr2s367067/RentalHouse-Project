//
//  RoomUpdateSheetView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/10/16.
//

import SwiftUI

struct RoomUpdateSheetView: View {
    
    @EnvironmentObject var errorHandler: ErrorHandler
    
    @State var roomInfo: RoomPostDM
    
    init(roomInfo: RoomPostDM) {
        UITextView.appearance().backgroundColor = .clear
        self.roomInfo = roomInfo
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
//                    CustomTextFieldWithName(
//                        title: "Room Size",
//                        infoContain: $roomInfo.roomSize,
//                        fieldName: "Please enter room size",
//                        hasContain: roomInfo.roomSize.isEmpty
//                    )
//                    CustomTextFieldWithName(
//                        title: "Room Address",
//                        infoContain: $roomInfo.roomAddress,
//                        fieldName: "Please enter room address",
//                        hasContain: roomInfo.roomAddress.isEmpty
//                    )
//                    CustomTextFieldWithName(
//                        title: "Rental Price",
//                        infoContain: $roomInfo.rentalPrice,
//                        fieldName: "Please enter rental price",
//                        hasContain: roomInfo.rentalPrice.isEmpty
//                    )
                    VStack {
                        HStack {
                            Text("Room Introdution")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        TextEditor(text: $roomInfo.additionalInfo)
                            .padding()
                            .frame(width: AppVM.uiScreenWidth * 0.91, height: AppVM.uiScreenHeight * 0.4)
                            .background { Color.white}
                            .cornerRadius(15)
                        Divider()
                            .background(.white.opacity(0.5))
                            .frame(height: 2)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .background {
            Color("GeneralBackground")
                .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

struct RoomUpdateSheetView_Previews: PreviewProvider {
    static let pacVM = PostAndCollectionVM()
    static let errorHandler = ErrorHandler()
    static var previews: some View {
        RoomUpdateSheetView(roomInfo: .dummy)
            .environmentObject(pacVM)
            .environmentObject(errorHandler)
    }
}
