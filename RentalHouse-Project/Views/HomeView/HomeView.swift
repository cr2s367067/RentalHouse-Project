//
//  HomeView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/30.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var pacVM: PostAndCollectionVM
    @EnvironmentObject var errorHandler: ErrorHandler
    @State private var searchingContext = ""
    @State private var show = false
    var body: some View {
        SideMenuBar(sidebarWidth: AppVM.uiScreenWidth * 0.34, showSidebar: $show) {
            MenuView()
        } content: {
            homeContain()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static let pacVM = PostAndCollectionVM()
    static var previews: some View {
        HomeView()
            .environmentObject(pacVM)
            .withErrorHandler()
    }
}

extension HomeView {
    @ViewBuilder
    func homeContain() -> some View {
        VStack {
            HStack {
                Button {
                    show.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.circle")
                        .foregroundColor(.black.opacity(0.8))
                        .font(.title)
                }
                Text("Find Your Perfect Spot")
                    .font(.title)
                    .fontWeight(.heavy)
                Spacer()
            }
            SearchBar(input: $searchingContext)
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(pacVM.houseCollection) { room in
//                    ReuseableCard(roomAddress: room.roomAddress, roomPrice: room.rentalPrice, roomsImage: room.roomsImage)
                }
            }
        }
        .modifier(ViewBackground(backgroundType: .naviBarIsHidden))
        .task {
            do {
                try await pacVM.fetchPostedRoom(from: .external)
            } catch {
                errorHandler.handler(error: error)
            }
        }
    }
}
