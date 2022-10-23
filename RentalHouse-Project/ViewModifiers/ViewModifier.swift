//
//  ViewModifier.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/28.
//

import Foundation
import SwiftUI


struct FlatGlass: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 15.0, *) {
            content
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(15)
        } else {
            content
                .padding()
                .frame(height: 50)
                .cornerRadius(15)
        }
    }
}

enum BackgroundType {
    case naviBarIsHidden
    case naviBarIsShown
    case generalBackground
}

struct ViewBackground: ViewModifier {
    var backgroundType: BackgroundType = .naviBarIsShown
    var navigationTitle: String = ""
    @StateObject var appVM = AppVM()
    
    func body(content: Content) -> some View {
        
        switch backgroundType {
        case .naviBarIsHidden:
            content
                .navigationTitle(navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(alignment: .center) {
                    Image("room")
                    Color.black.opacity(0.6)
                        .edgesIgnoringSafeArea([.top, .bottom])
                }
        case .naviBarIsShown:
            content
                .navigationTitle(navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(false)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(alignment: .center) {
                    Image("room")
                    Color.black.opacity(0.6)
                        .edgesIgnoringSafeArea([.top, .bottom])
                }
        case .generalBackground:
            content
                .navigationTitle(navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(alignment: .center) {
                    Color("GeneralBackground")
                        .edgesIgnoringSafeArea([.top, .bottom])
                }
        }
    }
}

struct HandlerErrorByShowingAlertViewModifier: ViewModifier {
    @StateObject var errorHandler = ErrorHandler()
    func body(content: Content) -> some View {
        content
            .environmentObject(errorHandler)
            .background(alignment: .center) {
                EmptyView()
                    .alert(item: $errorHandler.errorAlert) { alert in
                        Alert(title: Text("Error"), message: Text(alert.message), dismissButton: .default(Text("Ok")))
                    }
            }
    }
}


struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(.white)
            .frame(width: AppVM.uiScreenWidth * 0.97, height: AppVM.uiScreenHeight * 0.07)
            .background(alignment: .center) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.gray.opacity(0.5))
            }
    }
}


//TODO: Add the custom image background style toggle
//struct ImageBackgroundToggleStyle: ToggleStyle {
//    func makeBody(configuration: Configuration) -> some View {
//
//    }
//}
