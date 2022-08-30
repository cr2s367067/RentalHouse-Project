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

struct ViewBackground: ViewModifier {
    @StateObject var appVM = AppVM()
    func body(content: Content) -> some View {
        content
            .padding()
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(alignment: .center) {
                LinearGradient(colors: [Color(appVM.randomGredientColor1), Color(appVM.randomGredientColor2)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea([.top, .bottom])
            }
    }
}
