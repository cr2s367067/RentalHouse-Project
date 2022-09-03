//
//  HousePostView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import SwiftUI

struct HousePostView: View {
    @State private var temp: RoomPostDM = .empty
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
                ReuseableInfoTextField(fieldName: "Room Size", layoutType: .horizontal, input: $temp.roomSize)
                
                ReuseableInfoTextField(fieldName: "Room Address", layoutType: .vertical, input: $temp.roomAddress)
                ReuseableInfoTextField(fieldName: "Rental Price", layoutType: .horizontal, input: $temp.rentalPrice)
                TitleAndDivier(title: "Confirm and Upload")
                ReuseableCofirmCheckBoxWithStatement(statement: "I have check room info.", isAgree: temp.tosAgree) {
                    temp.tosAgree.toggle()
                }
                Button {
                    //Uploading process
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
