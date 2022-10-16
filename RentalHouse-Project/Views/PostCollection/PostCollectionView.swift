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
            collectionEmptyCheck()
        }
        .scrollDisabled(pacVM.providerCollection.isEmpty ? true : false)
        .modifier(ViewBackground(backgroundType: .generalBackground, navigationTitle: AppVM.NanigationTitles.roomCollection.rawValue))
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

extension PostCollectionView {
    @ViewBuilder
    func collectionEmptyCheck() -> some View {
        if pacVM.providerCollection.isEmpty {
            VStack {
                Text("Hi, you havn't post any room😅")
                    .foregroundColor(.white)
                    .font(.title2)
            }
        } else {
            VStack {
                //for each this card
                ForEach(pacVM.providerCollection) { room in
                    NavigationLink {
                        RoomDetailView(roomInfo: room)
                    } label: {
                        ReuseableRoomItemCard(roomData: room)
                    }

                }
            }

        }
    }
}
