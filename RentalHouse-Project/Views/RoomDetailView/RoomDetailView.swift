//
//  RoomDetailView.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/18.
//

import SwiftUI
import SDWebImageSwiftUI

struct RoomDetailView: View {
    
    enum PostStatus: String {
        case isPublic = "Public"
        case isPrivate = "Private"
    }
    
    @EnvironmentObject var errorHandler: ErrorHandler
    @EnvironmentObject var pacVM: PostAndCollectionVM
    
    @State private var isPost = false
    @State private var isEdit = false
    @State var roomInfo: RoomPostDM?
    @State private var postStatus: PostStatus = .isPrivate
    
    @State private var tempHolder: RoomPostDM = .empty

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
                    Text("坪數: \(roomInfo.roomSize)")
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
                if AppVM.navigationLocate == .isLocal {
                    Spacer()
                    Button {
                        
                    } label: {
                        Text("Remove Room")
                            .font(.body)
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .frame(width: AppVM.uiScreenWidth * 0.97, height: AppVM.uiScreenHeight * 0.05, alignment: .center)
                    }
                    .background(alignment: .center) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.red)
                    }
                }
            }
            Spacer()
        }
        .sheet(isPresented: $isEdit, onDismiss: {
            Task {
                do {
                    guard AppVM.navigationLocate == .isLocal else { return }
                    //FIXME: Neet to fix the comparing logic.
                    debugPrint("roominfo: \(roomInfo), tempholder: \(tempHolder)")
                    guard !AppVM.isSame(lhs: roomInfo, rhs: tempHolder) else { return }
                    try await pacVM.roomInfoUpdate(roomUID: roomInfo?.id ?? "")
                } catch {
                    errorHandler.handler(error: error)
                }
            }
        }, content: {
            if let roomInfo = roomInfo {
                RoomUpdateSheetView(roomInfo: roomInfo)
            }
        })
        .modifier(ViewBackground(backgroundType: .generalBackground))
        .navigationBarHidden(false)
        .onAppear {
            if let roomInfo = roomInfo {
                isPost = roomInfo.isOnPublic
                self.tempHolder = roomInfo
            }
        }
        .toolbar {
            if AppVM.navigationLocate == .isLocal {
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Text(postStatus.rawValue)
                            .foregroundColor(isPost ? .green : .red)
                        Toggle("PostPublic", isOn: $isPost)
                            .toggleStyle(.switch)
                            .labelsHidden()
                            .onChange(of: isPost) { _ in
                                if isPost {
                                    postStatus = .isPublic
                                    //TODO: Post in public
                                } else {
                                    postStatus = .isPrivate
                                    //TODO: remove from public
                                }
                            }
                        Button {
                            withAnimation {
                                isEdit.toggle()
                            }
                        } label: {
                            Image(systemName: "slider.horizontal.3")
                                .foregroundColor(.white)
                                .font(.body)
                        }
                    }
                    .padding(.horizontal)
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
