//
//  RoomUpdateSheetView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/10/16.
//

import SwiftUI

struct RoomUpdateSheetView: View {
    @EnvironmentObject var pacVM: PostAndCollectionVM
    @EnvironmentObject var errorHandler: ErrorHandler
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    CustomTextFieldWithName(title: "Room Size", infoContain: $pacVM.roomData.roomSize, fieldName: "Please enter room size", hasContain: pacVM.roomData.roomSize.isEmpty)
                    CustomTextFieldWithName(title: "Room Address", infoContain: $pacVM.roomData.roomAddress, fieldName: "Please enter room address", hasContain: pacVM.roomData.roomAddress.isEmpty)
                    CustomTextFieldWithName(title: "Rental Price", infoContain: $pacVM.roomData.rentalPrice, fieldName: "Please enter rental price", hasContain: pacVM.roomData.rentalPrice.isEmpty)
                    VStack {
                        HStack {
                            Text("Room Introdution")
                                .foregroundColor(.white)
                            Spacer()
                        }
                        TextEditor(text: $pacVM.roomData.additionalInfo)
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
        RoomUpdateSheetView()
            .environmentObject(pacVM)
            .environmentObject(errorHandler)
    }
}
