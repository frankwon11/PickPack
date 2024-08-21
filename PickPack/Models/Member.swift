//
//  Member.swift
//  PickPack
//
//  Created by LDW on 8/21/24.
//

import Foundation

struct Member: Identifiable, Codable, Hashable {
    let id: String
    
    let user: User
    
    var itemList: [Item]
    
    var color: MemberColor
    
    
    
}

enum MemberColor: String, Codable, Hashable {
    case green
    case till
    case blue
    case indigo
    case purple
    case pink
}
