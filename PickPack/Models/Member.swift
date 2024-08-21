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
}
