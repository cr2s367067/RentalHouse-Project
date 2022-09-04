//
//  ErrorHandler.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/4.
//

import Foundation


struct ErrorAlert: Identifiable {
    var id = UUID()
    var message: String
    var dismissAction: (()->Void)?
}

class ErrorHandler: ObservableObject {
    
    @Published var errorAlert: ErrorAlert? = nil
    
    func handler(error: Error, dismissAction: (()->Void)? = nil) {
        dismissAction?()
        errorAlert = ErrorAlert(message: error.localizedDescription)
    }
}
