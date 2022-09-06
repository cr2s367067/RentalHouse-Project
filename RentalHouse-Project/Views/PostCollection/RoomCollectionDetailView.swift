//
//  RoomCollectionDetailView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/6.
//

import SwiftUI

struct RoomCollectionDetailView: View {
    var roomData: RoomPostDM
    var body: some View {
        VStack {
            Text(roomData.roomAddress)
        }
        .modifier(ViewBackground(backgroundType: .naviBarIsShown))
    }
}

struct RoomCollectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RoomCollectionDetailView(roomData: .dummy)
    }
}
