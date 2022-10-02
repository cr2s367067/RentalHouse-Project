//
//  ErrorHandler.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/4.
//

import Foundation


enum RoomPostError: LocalizedError {
    case infoEmpty
    
    var errorDescription: String? {
        switch self {
        case .infoEmpty:
            return NSLocalizedString("Please, fill out whole blank", comment: "")
        }
    }
}


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
