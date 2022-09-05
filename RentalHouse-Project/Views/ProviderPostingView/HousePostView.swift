//
//  HousePostView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import SwiftUI

struct HousePostView: View {
    
    @EnvironmentObject var pacVM: PostAndCollectionVM
    @EnvironmentObject var errorHandler: ErrorHandler
    
    @State private var isHouseOwner = false
    @State private var isHouseManager = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 10) {
                TitleAndDivier(title: "Picking Room image")
                Button {
                    
                } label: {
                    Label("Photo Picker", systemImage: "plus.square")
                        .foregroundColor(.black)
                        .font(.title3)
                }
                .frame(width: AppVM.uiScreenWidth * 0.80, height: AppVM.uiScreenHeight * 0.3, alignment: .center)
                .modifier(FlatGlass())
                TitleAndDivier(title: "Room Infomation")
                HStack {
                    ReuseableButtonProviderType(buttonName: .houseOwner, isSelected: isHouseOwner) {
                        isHouseOwner = true
                        pacVM.roomData.providerType = ProviderType.houseOwner.rawValue
                        if isHouseManager {
                            isHouseManager = false
                        }
                    }
                    Spacer()
                        .frame(width: AppVM.uiScreenWidth * 0.1)
                    ReuseableButtonProviderType(buttonName: .rentalManager, isSelected: isHouseManager) {
                        isHouseManager = true
                        pacVM.roomData.providerType = ProviderType.rentalManager.rawValue
                        if isHouseOwner {
                            isHouseOwner = false
                        }
                    }
                }
                .frame(width: AppVM.uiScreenWidth * 0.8)
                ReuseableInfoTextField(fieldName: "Room Size", layoutType: .horizontal, input: $pacVM.roomData.roomSize)
                
                ReuseableInfoTextField(fieldName: "Room Address", layoutType: .vertical, input: $pacVM.roomData.roomAddress)
                ReuseableInfoTextField(fieldName: "Rental Price", layoutType: .horizontal, input: $pacVM.roomData.rentalPrice)
                TitleAndDivier(title: "Confirm and Upload")
                ReuseableCofirmCheckBoxWithStatement(statement: "I have check room info.", isAgree: pacVM.roomData.tosAgree) {
                    pacVM.roomData.tosAgree.toggle()
                }
                Button {
                    Task {
                        do {
                            //Uploading process
                            //1. upload photos
                            
                            //2. upload rooms data
                            try await pacVM.roomUpload()
                        } catch {
                            errorHandler.handler(error: error)
                        }
                    }
                } label: {
                    Text("Post Room")
                        .foregroundColor(.white)
                        .font(.body)
                        .fontWeight(.bold)
                }
                .frame(width: AppVM.uiScreenWidth * 0.3, height: AppVM.uiScreenHeight * 0.04, alignment: .center)
                .background(alignment: .center) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("ButtonBackground"))
                }
            }
        }
        .modifier(ViewBackground(backgroundType: .naviBarIsShown))
    }
}

struct HousePostView_Previews: PreviewProvider {
    static var previews: some View {
        HousePostView()
    }
}
