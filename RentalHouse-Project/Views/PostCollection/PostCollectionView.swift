//
//  PostCollectionView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/3.
//

import SwiftUI

struct PostCollectionView: View {
    @EnvironmentObject var pacVM: PostAndCollectionVM
    @EnvironmentObject var errorHandler: ErrorHandler
    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack {
                TitleAndDivier(title: "Room Collection")
                //for each this card
                ForEach(pacVM.providerCollection) { room in
                    ReuseableRoomItemCard(roomData: room)
                }
            }
        }
        .modifier(ViewBackground(backgroundType: .naviBarIsShown))
        .task {
            do {
                try await pacVM.fetchPostedRoom(from: .inside)
            } catch {
                errorHandler.handler(error: error)
            }
        }
    }
}

struct PostCollectionView_Previews: PreviewProvider {
    static let pacVM = PostAndCollectionVM()
    static var previews: some View {
        PostCollectionView()
            .environmentObject(pacVM)
            .withErrorHandler()
    }
}
