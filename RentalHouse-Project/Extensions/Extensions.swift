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
            placeholder().opacity(showText ? 1 : 0)
            self
        }
    }
}
