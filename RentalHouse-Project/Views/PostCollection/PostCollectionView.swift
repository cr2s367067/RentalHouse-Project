//
//  PostCollectionView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/3.
//

import SwiftUI

struct PostCollectionView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                TitleAndDivier(title: "Room Collection")
                //for each this card
                ReuseableRoomItemCard(roomData: .empty)
            }
        }
        .modifier(ViewBackground(backgroundType: .naviBarIsShown))
    }
}

struct PostCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        PostCollectionView()
    }
}
