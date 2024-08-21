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
    
    var color: MemberColor
}

enum MemberColor: String, Codable, Hashable {
    case green = "green"
    case teal = "teal"
    case blue = "blue"
    case indigo = "indigo"
    case purple = "purple"
    case pink = "pink"
    
    var color: Color {
        switch self {
        case .green:
            return Color.green
        case .teal:
            return Color.teal
        case .blue:
            return Color.blue
        case .indigo:
            return Color.indigo
        case .purple:
            return Color.purple
        case .pink:
            return Color.pink
        }
    }
}
