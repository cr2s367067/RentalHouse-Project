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
    @State private var showPhpicker = false
    @State private var selectedLimit = 4
    var body: some View {
        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: AppVM.uiScreenHeight * 0.04) {
                    postHeader(title: "Room Photos Upload")
                    HStack {
                        photoPicker()
                        Spacer()
                    }
//                    //if photo is selected
//                    HStack {
//
//                    }
                    Group{
                        //MARK: - Provider type
                        postHeader(title: "Room Infomation")
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
                    }
                    PostViewTitleAndTextField(title: "Room Size", roomInfoContain: $pacVM.roomData.roomSize, fieldName: "Please enter room size", hasContain: pacVM.roomData.roomSize.isEmpty)
                    PostViewTitleAndTextField(title: "Room Address", roomInfoContain: $pacVM.roomData.roomAddress, fieldName: "Please enter room address", hasContain: pacVM.roomData.roomAddress.isEmpty)
                    PostViewTitleAndTextField(title: "Rental Price", roomInfoContain: $pacVM.roomData.rentalPrice, fieldName: "Please enter rental price", hasContain: pacVM.roomData.rentalPrice.isEmpty)
                    PostViewTitleAndTextField(title: "Room Introdution", roomInfoContain: $pacVM.roomData.additionalInfo, fieldName: "Please introduce this room", hasContain: pacVM.roomData.additionalInfo.isEmpty)
                }
            }
            .padding()
            .background {
                Color("ContainBackground")
                    .offset(y: AppVM.uiScreenHeight * 0.005)
                    .frame(height: AppVM.uiScreenHeight * 0.83)
                    .edgesIgnoringSafeArea([.bottom])
            }
            Button {
                Task {
                    do {
                        try await pacVM.roomCreateProcess()
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
            .offset(y: AppVM.uiScreenHeight * 0.03)
            .frame(width: AppVM.uiScreenWidth, height: AppVM.uiScreenHeight * 0.07, alignment: .center)
            .background(alignment: .center) {
                Color("ButtonBackground")
                    .offset(y: AppVM.uiScreenHeight * 0.042)
                    .frame(height: AppVM.uiScreenHeight * 0.12)
                    .edgesIgnoringSafeArea([.bottom])
            }
        }
        .modifier(ViewBackground(backgroundType: .generalBackground))
        //.navigationTitle("Post")
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
        @StateObject private var pacVM = PostAndCollectionVM()
        @StateObject private var errorHandler = ErrorHandler()
        var body: some View {
            PhotosPicker(selection: $pacVM_ios16.selectedPhotos, maxSelectionCount: 5, matching: .images) {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .background {
                        Rectangle()
                            .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [10]))
                    }
            }
            .onChange(of: pacVM_ios16.selectedPhotos) { newValue in
                Task {
                    do {
                        for item in newValue {
                            guard let data = try await item.loadTransferable(type: Data.self) else { return }
                            if let image = UIImage(data: data) {
                                pacVM.imageManager.append(image)
                            }
                        }
                        debugPrint("Selected Image: \(pacVM.imageManager), contain amount: \(pacVM.imageManager.count)")
                    } catch {
                        errorHandler.handler(error: error)
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    func photoPicker() -> some View {
        if #available(iOS 16, *) {
            PhotoPicker_ios16()
        } else {
            Button {
                showPhpicker.toggle()
            } label: {
                Label("Photo Picker", systemImage: "plus.square")
                    .foregroundColor(.black)
                    .font(.title3)
            }
            .frame(width: AppVM.uiScreenWidth * 0.80, height: AppVM.uiScreenHeight * 0.3, alignment: .center)
            .modifier(FlatGlass())
            .sheet(isPresented: $showPhpicker) {
                PHPickerRepresentable(selectLimit: $selectedLimit, images: $pacVM.imageManager)
            }
        }
    }
    
    @ViewBuilder
    func postHeader(title: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .fontWeight(.bold)
            Spacer()
        }
    }
}
