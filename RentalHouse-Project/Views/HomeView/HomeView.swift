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
    @EnvironmentObject var userAuthVM: UserAuthenticationVM
    @State private var searchingContext = ""
    @State private var show = false
    @State private var homePath = NavigationPath()
    var body: some View {
        NavigationStack(path: $homePath) {
            SideMenuBar(sidebarWidth: AppVM.uiScreenWidth * 0.6, showSidebar: $show) {
                CustomMenuView()
            } content: {
                homeContain()
            }
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
                    withAnimation {
                        show.toggle()
                    }
                } label: {
                    Image(systemName: "line.3.horizontal")
                        .foregroundColor(.white)
                        .font(.title)
                }
                SearchBar(input: $searchingContext)
            }
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(pacVM.houseCollection) { room in
                    NavigationLink {
                        RoomDetailView(roomInfo: room)
                            .environmentObject(errorHandler)
                    } label: {
                        ReuseableCard(
                            roomAddress: room.roomAddress,
                            roomIntro: room.additionalInfo,
                            roomPrice: room.rentalPrice,
                            roomsImage: room.roomsImage
                        )
                    }
                    .padding(.top, 18)
                }
            }
        }
        .modifier(ViewBackground(backgroundType: .generalBackground))
        .navigationBarHidden(true)
        .onAppear {
            AppVM.navigationLocate = .isPublic
        }
        .task {
            do {
                try await userAuthVM.getUser()
                try await pacVM.fetchPostedRoom(from: .external)
            } catch {
                errorHandler.handler(error: error)
            }
        }
    }
}
