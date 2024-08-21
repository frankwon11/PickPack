//
//  Item.swift
//  PickPack
//
//  Created by sseungwonnn on 8/16/24.
//

import Foundation

struct Item: Identifiable, Codable {
    let id: String
    
    let name: String
    
    let theme: ItemTheme
    
    var isShared: Bool = false
      
    var isHidden: Bool = false
    
    var isPacked: Bool = false
    
    var quantity: Int = 1
}

enum ItemTheme: String, Codable, CaseIterable {
    case essentials = "필수품"
    case documents = "서류"
    case toiletries = "세면용품"
    case clothing = "의류"
    case cosmetics = "화장품"
    case medication = "의약품"
    case officeSupplies = "사무용품"
    case electronics = "전자기기"
    case swimGear = "수영용품"
    case golfGear = "골프용품"
    case seasonalItems = "계절용품"
    case others = "기타"
}
