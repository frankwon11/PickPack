//
//  Room.swift
//  PickPack
//
//  Created by LDW on 8/21/24.
//

import Foundation

struct Room: Identifiable, Codable, Hashable {
    let id: String
    
    let code: String
    
    let startDate: Date
    
    let endDate: Date

    var name: String
    
    var color: CustomColor

    var memeberList: [Member]
    
    var sharedItemList: [SharedItem]
}
