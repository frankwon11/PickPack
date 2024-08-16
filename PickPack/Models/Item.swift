//
//  Item.swift
//  PickPack
//
//  Created by sseungwonnn on 8/16/24.
//

import Foundation

struct Item: Codable {
    let id: String
    
    let name: String
    
    let theme: ItemTheme
}

enum ItemTheme: String, Codable {
    case essentials = "필수품"
    case documents = "서류"
    case toiletries = "세면용품"
    case clothing = "의류"
    case cosmetics = "화장품"
    case medication = "의약품"
    case officeSupplies = "사무용품"
    case swimGear = "수영용품"
    case golfGear = "골프용품"
    case others = "기타"
}
