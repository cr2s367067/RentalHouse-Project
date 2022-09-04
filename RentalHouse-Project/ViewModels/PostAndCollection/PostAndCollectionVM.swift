//
//  PostAndCollectionVM.swift
//  RentalHouse-Project
//
//  Created by Kuan on 2022/9/3.
//

import Foundation

class PostAndCollectionVM: ObservableObject {
    
    let fireDB = FirestoreDB()
    
    @Published var houseCollection = [RoomPostDM]()
    @Published var postingData: RoomPostDM = .empty
    
    
    
}
