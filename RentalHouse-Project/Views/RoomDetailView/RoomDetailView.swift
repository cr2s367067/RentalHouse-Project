//
//  RoomDetailView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/18.
//

import SwiftUI

struct RoomDetailView: View {
    var roomInfo: RoomPostDM
    var body: some View {
        VStack {
            Text("地址: \(roomInfo.roomAddress)")
            Text(roomInfo.additionalInfo)
            Text("聯絡人: \(roomInfo.providerInfo)")
            Text("聯絡方式: \(roomInfo.providerInfo)")
            Text("$\(roomInfo.rentalPrice)/月")
        }
    }
}

struct RoomDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RoomDetailView(roomInfo: .empty)
    }
}
