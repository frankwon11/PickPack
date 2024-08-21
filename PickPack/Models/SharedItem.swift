//
//  SharedItem.swift
//  PickPack
//
//  Created by LDW on 8/21/24.
//

import Foundation

struct SharedItem: Identifiable, Codable, Hashable {
    let id: String

    var name: String
    
    var item: Item
    
    var ownerId: String
    
    var sharedMemberIdList: [String]
}
