//
//  RoomDetailView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/18.
//

import SwiftUI
import SDWebImageSwiftUI

struct RoomDetailView: View {
    var roomInfo: RoomPostDM
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "photo")
                .frame(width: AppVM.uiScreenWidth * 0.9, height: AppVM.uiScreenHeight * 0.3)
                .background {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white.opacity(0.7))
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
                    .frame(width: AppVM.uiScreenWidth * 0.23, height: AppVM.uiScreenHeight * 0.03)
                    .background {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(.gray)
                    }
                Spacer()
            }
            Spacer()
        }
        .modifier(ViewBackground(backgroundType: .generalBackground))
        .navigationBarHidden(false)
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