//
//  Extensions.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/27.
//

import Foundation
import SwiftUI

//extension Color {
//  init(_ hex: UInt, alpha: Double = 1) {
//    self.init(
//      .sRGB,
//      red: Double((hex >> 16) & 0xFF) / 255,
//      green: Double((hex >> 8) & 0xFF) / 255,
//      blue: Double(hex & 0xFF) / 255,
//      opacity: alpha
//    )
//  }
//}


struct SideMenuBar<SidebarContent: View, Content: View>: View {
    let sidebarContent: SidebarContent
    let mainContent: Content
    let sidebarWidth: CGFloat
    @Binding var showSidebar: Bool
    
    init(
        sidebarWidth: CGFloat,
        showSidebar: Binding<Bool>,
        @ViewBuilder sidebar: () -> SidebarContent,
        @ViewBuilder content: () -> Content
    ) {
        self.sidebarWidth = sidebarWidth
        _showSidebar = showSidebar
        sidebarContent = sidebar()
        mainContent = content()
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            sidebarContent
                .frame(width: sidebarWidth, alignment: .leading)
                .offset(x: showSidebar ? 0 : -1 * sidebarWidth, y: 0)
                .animation(.easeInOut, value: 2)
            mainContent
                .overlay(
                    Group {
                        if showSidebar {
                            Color.white
                                .opacity(showSidebar ? 0.01 : 0)
                                .onTapGesture {
                                    self.showSidebar = false
                                }
                        } else {
                            Color.clear
                                .opacity(showSidebar ? 0 : 0)
                                .onTapGesture {
                                    self.showSidebar = false
                                }
                        }
                    }
                )
                .offset(x: showSidebar ? sidebarWidth : 0, y: 0)
                .animation(.easeInOut, value: 2)
        }
    }
}
