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
}
