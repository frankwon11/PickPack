//
//  Room.swift
//  PickPack
//
//  Created by LDW on 8/21/24.
//

import Foundation

struct Room: Identifiable, Codable, Hashable {
    let id: String

    var name: String
    
    var color: CustomColor

}
