//
//  ItemList.swift
//  PickPack
//
//  Created by sseungwonnn on 8/16/24.
//

import Foundation

struct ItemList: Codable {
    var items: [Item]
    
    init() {
        self.items = []
        addDefaultItems()
    }
    
    mutating func addDefaultItems() {
        items.append(contentsOf: [
            // 필수품
            Item(id: UUID().uuidString, name: "신분증", theme: .essentials),
            Item(id: UUID().uuidString, name: "여권", theme: .essentials),
            Item(id: UUID().uuidString, name: "지갑", theme: .essentials),
            Item(id: UUID().uuidString, name: "현금", theme: .essentials),
            
            // 서류
            Item(id: UUID().uuidString, name: "여행 일정표", theme: .documents),
            Item(id: UUID().uuidString, name: "호텔 예약 확인서", theme: .documents),
            Item(id: UUID().uuidString, name: "비자", theme: .documents),
            
            // 세면용품
            Item(id: UUID().uuidString, name: "샴푸", theme: .toiletries),
            Item(id: UUID().uuidString, name: "바디워시", theme: .toiletries),
            Item(id: UUID().uuidString, name: "치약", theme: .toiletries),
            Item(id: UUID().uuidString, name: "칫솔", theme: .toiletries),
            Item(id: UUID().uuidString, name: "폼클렌징", theme: .toiletries),
            Item(id: UUID().uuidString, name: "클렌징오일", theme: .toiletries),
            
            // 의류
            Item(id: UUID().uuidString, name: "속옷", theme: .clothing),
            Item(id: UUID().uuidString, name: "양말", theme: .clothing),
            Item(id: UUID().uuidString, name: "상의", theme: .clothing),
            Item(id: UUID().uuidString, name: "하의", theme: .clothing),
            Item(id: UUID().uuidString, name: "겉옷", theme: .clothing),
            Item(id: UUID().uuidString, name: "신발", theme: .clothing),
            
            // 화장품
            Item(id: UUID().uuidString, name: "스킨", theme: .cosmetics),
            Item(id: UUID().uuidString, name: "로션", theme: .cosmetics),
            Item(id: UUID().uuidString, name: "선크림", theme: .cosmetics),
            
            // 의약품
            Item(id: UUID().uuidString, name: "상비약", theme: .medication),
            Item(id: UUID().uuidString, name: "밴드", theme: .medication),
            Item(id: UUID().uuidString, name: "소독약", theme: .medication),
            
            // 사무용품
            Item(id: UUID().uuidString, name: "노트북", theme: .officeSupplies),
            Item(id: UUID().uuidString, name: "충전기", theme: .officeSupplies),
            Item(id: UUID().uuidString, name: "다이어리", theme: .officeSupplies),
            
            // 수영용품
            Item(id: UUID().uuidString, name: "수영복", theme: .swimGear),
            Item(id: UUID().uuidString, name: "수영모", theme: .swimGear),
            Item(id: UUID().uuidString, name: "수경", theme: .swimGear),
            
            // 골프용품
            Item(id: UUID().uuidString, name: "골프 클럽", theme: .golfGear),
            Item(id: UUID().uuidString, name: "골프공", theme: .golfGear),
            Item(id: UUID().uuidString, name: "골프화", theme: .golfGear),
            
            // 기타
//            Item(id: UUID().uuidString, name: "휴대폰", theme: .others),
        ])
    }
    
    mutating func addItem(_ item: Item) {
        items.append(item)
    }
    
    mutating func removeItem(_ item: Item) {
        items.removeAll { $0.id == item.id }
    }
    
    func filterItems(by theme: ItemTheme) -> [Item] {
        return items.filter { $0.theme == theme }
    }
}
