//
//  HousePostView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import SwiftUI
import PhotosUI

struct HousePostView: View {
    
    @EnvironmentObject var pacVM: PostAndCollectionVM
    @EnvironmentObject var errorHandler: ErrorHandler
    
    @State private var isHouseOwner = false
    @State private var isHouseManager = false
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 10) {
                TitleAndDivier(title: "Picking Room image")
                photoPicker()
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
                            try await pacVM.roomUpload(to: .inside)
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
    static let pacVM = PostAndCollectionVM()
    static let errorHandler = ErrorHandler()
    static var previews: some View {
        HousePostView()
            .environmentObject(pacVM)
            .environmentObject(errorHandler)
    }
}


extension HousePostView {
    
    @available(iOS 16, *)
    struct PhotoPicker_ios16: View {
        @StateObject private var pacVM_ios16 = PostAndCollectionVM_ios16()
        var body: some View {
            PhotosPicker(selection: $pacVM_ios16.test) {
                Label("Photo Picker", systemImage: "plus.square")
                    .foregroundColor(.black)
                    .font(.title3)
            }
        }
    }
    
    @ViewBuilder
    func photoPicker() -> some View {
        if #available(iOS 16, *) {
            PhotoPicker_ios16()
        } else {
            Button {
                
            } label: {
                Label("Photo Picker", systemImage: "plus.square")
                    .foregroundColor(.black)
                    .font(.title3)
            }
            .frame(width: AppVM.uiScreenWidth * 0.80, height: AppVM.uiScreenHeight * 0.3, alignment: .center)
            .modifier(FlatGlass())
        }
    }
}
