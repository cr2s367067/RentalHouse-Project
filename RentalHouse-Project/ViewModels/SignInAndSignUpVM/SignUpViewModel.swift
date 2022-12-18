//
//  SignUpViewModel.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/12/18.
//

import Foundation
import SwiftUI


class SignUpViewModel: ObservableObject {
    
    @Published var leftIsSelected: Bool
    @Published var rightIsSelected: Bool
    @Published var summitCheck: Bool
    
    init(
        leftIsSelected: Bool = false,
        rightIsSelected: Bool = false,
        summitCheck: Bool = false
    ) {
        self.leftIsSelected = leftIsSelected
        self.rightIsSelected = rightIsSelected
        self.summitCheck = summitCheck
    }
    
    func isInSummitCheckMode<Content: View>(
        check contain: String,
        @ViewBuilder content: ()->Content) {
        if self.summitCheck {
            if contain.isEmpty {
                HStack {
                    content()
                        .foregroundColor(Color(AppVM.ColorSet.cautionTextColor.rawValue))
                }
            }
        }
    }
    
}
