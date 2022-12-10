//
//  Extensions.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/8/27.
//

import Foundation
import SwiftUI


extension View {
    func withErrorHandler() -> some View {
        modifier(HandlerErrorByShowingAlertViewModifier())
    }
    
    func placeholder<Content: View>(
        when showText: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: ()->Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder()
                .opacity(showText ? 1 : 0)
            self
        }
        .padding(.leading, 10)
    }
}

extension Color {
    
    init?(hex: String) {
        var hexSaninitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSaninitized = hexSaninitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        
        var r:CGFloat = 0.0
        var g:CGFloat = 0.0
        var b:CGFloat = 0.0
        var a:CGFloat = 0.0
        
        let length = hexSaninitized.count
        
        guard Scanner(string: hexSaninitized).scanHexInt64(&rgb) else { return nil }
        
        if length == 6 {
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            b = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            g = CGFloat(rgb & 0x0000FF) / 255.0
        } else if length == 8 {
            r = CGFloat((rgb & 0xFF000000) >> 24) / 255.0
            b = CGFloat((rgb & 0x00FF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x0000FF00) >> 8) / 255.0
            a = CGFloat(rgb & 0x000000FF) / 255.0
        } else {
            return nil
        }
        
        self.init(red: r, green: g, blue: b, opacity: a)
    }
    
}
