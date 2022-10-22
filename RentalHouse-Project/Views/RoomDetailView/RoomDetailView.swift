//
//  RoomDetailView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/18.
//

import SwiftUI
import SDWebImageSwiftUI

struct RoomDetailView: View {
    
    @State private var isEdit = false
    @State var roomInfo: RoomPostDM?

    var body: some View {
        VStack(spacing: 20) {
            if let roomInfo = roomInfo {
                if roomInfo.roomsImage.count > 1 {
                    PageHorizontalScrollView(imageSet: roomInfo.roomsImage)
                } else {
                    Image(systemName: "photo")
                        .frame(width: AppVM.uiScreenWidth * 0.9, height: AppVM.uiScreenHeight * 0.3)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white.opacity(0.7))
                        }
                }
                SessionUnit {
                    Text(roomInfo.additionalInfo)
                }
                SessionUnit {
                    Text("地址: \(roomInfo.roomAddress)")
                    Text("聯絡人: \(roomInfo.providerInfo)")
                    Text("聯絡方式: \(roomInfo.providerInfo)")
                }
                HStack {
                    Text("$\(roomInfo.rentalPrice)/月")
                        .foregroundColor(.white)
                        .frame(width: AppVM.uiScreenWidth * 0.23, height: AppVM.uiScreenHeight * 0.03)
                        .background {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(.gray)
                        }
                    Spacer()
                }
            }
            Spacer()
        }
        .sheet(isPresented: $isEdit, onDismiss: {
            print("Update room's info")
        }, content: {
            if let roomInfo = roomInfo {
                RoomUpdateSheetView(roomInfo: roomInfo)
            }
        })
        .modifier(ViewBackground(backgroundType: .generalBackground))
        .navigationBarHidden(false)
        .toolbar {
            if !(roomInfo?.isOnPublic ?? true) {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button("Test") {
                            print("Testing")
                        }
                        Button {
                            isEdit.toggle()
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.white)
                                .font(.body)
                        }
                    }
                }
            }
        }
    }
}

struct RoomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetailView(roomInfo: .dummy)
    }
}


struct SessionUnit<Content: View>: View {
    let mainContent: Content
    init(@ViewBuilder content: () -> Content) {
        mainContent = content()
    }
    
    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    mainContent
                }
                .foregroundColor(.white)
                Spacer()
            }
            .frame(width: AppVM.uiScreenWidth * 0.9)
            Divider()
                .frame(height: 0.7)
                .background {
                    Color.gray
                }
        }
    }
}
