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
}

struct ViewBackground: ViewModifier {
    var backgroundType: BackgroundType = .naviBarIsShown
    @StateObject var appVM = AppVM()
    func body(content: Content) -> some View {
        if backgroundType == .naviBarIsShown {
            content
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(alignment: .center) {
                    LinearGradient(colors: [Color(appVM.randomGredientColor1), Color(appVM.randomGredientColor2)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea([.top, .bottom])
                }
        } else {
            content
                .navigationTitle("")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(alignment: .center) {
                    LinearGradient(colors: [Color(appVM.randomGredientColor1), Color(appVM.randomGredientColor2)], startPoint: .topLeading, endPoint: .bottomTrailing)
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
