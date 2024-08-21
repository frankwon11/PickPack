//
//  Member.swift
//  PickPack
//
//  Created by LDW on 8/21/24.
//

import SwiftUI

struct Member: Identifiable, Codable, Hashable {
    let id: String
    
    let user: User
    
    var itemList: [Item]
    
    var color: CustomColor
    
    // Item을 itemList에 추가하는 메서드
    mutating func addItem(_ item: Item) {
        itemList.append(item)
    }
}
