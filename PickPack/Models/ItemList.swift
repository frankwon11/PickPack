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
            Item(id: UUID().uuidString, name: "여행자 보험", theme: .essentials),
            Item(id: UUID().uuidString, name: "유심", theme: .essentials),
            
            // 서류
            Item(id: UUID().uuidString, name: "여행 일정표", theme: .documents),
            Item(id: UUID().uuidString, name: "호텔 예약 확인서", theme: .documents),
            Item(id: UUID().uuidString, name: "비자", theme: .documents),
            Item(id: UUID().uuidString, name: "항공권", theme: .documents),
            Item(id: UUID().uuidString, name: "예약 바우처", theme: .documents),
            
            // 세면용품
            Item(id: UUID().uuidString, name: "샴푸", theme: .toiletries),
            Item(id: UUID().uuidString, name: "바디워시", theme: .toiletries),
            Item(id: UUID().uuidString, name: "치약", theme: .toiletries),
            Item(id: UUID().uuidString, name: "칫솔", theme: .toiletries),
            Item(id: UUID().uuidString, name: "가그린", theme: .toiletries),
            Item(id: UUID().uuidString, name: "폼클렌징", theme: .toiletries),
            Item(id: UUID().uuidString, name: "클렌징오일", theme: .toiletries),
            
            // 의류
            Item(id: UUID().uuidString, name: "속옷", theme: .clothing),
            Item(id: UUID().uuidString, name: "양말", theme: .clothing),
            Item(id: UUID().uuidString, name: "상의", theme: .clothing),
            Item(id: UUID().uuidString, name: "하의", theme: .clothing),
            Item(id: UUID().uuidString, name: "겉옷", theme: .clothing),
            Item(id: UUID().uuidString, name: "신발", theme: .clothing),
            Item(id: UUID().uuidString, name: "잠옷", theme: .clothing),
            Item(id: UUID().uuidString, name: "모자", theme: .clothing),
            Item(id: UUID().uuidString, name: "보조가방", theme: .clothing),
            
            // 화장품
            Item(id: UUID().uuidString, name: "스킨", theme: .cosmetics),
            Item(id: UUID().uuidString, name: "로션", theme: .cosmetics),
            Item(id: UUID().uuidString, name: "선크림", theme: .cosmetics),
            Item(id: UUID().uuidString, name: "마스크팩", theme: .cosmetics),
            Item(id: UUID().uuidString, name: "화장솜", theme: .cosmetics),
            
            // 의약품
            Item(id: UUID().uuidString, name: "상비약", theme: .medication),
            Item(id: UUID().uuidString, name: "밴드", theme: .medication),
            Item(id: UUID().uuidString, name: "소독약", theme: .medication),
            Item(id: UUID().uuidString, name: "소화제", theme: .medication),
            Item(id: UUID().uuidString, name: "진통제", theme: .medication),
            Item(id: UUID().uuidString, name: "멀미약", theme: .medication),
            Item(id: UUID().uuidString, name: "모기 기피제", theme: .medication),
            Item(id: UUID().uuidString, name: "위생용품", theme: .medication),
            
            // 사무용품
            Item(id: UUID().uuidString, name: "다이어리", theme: .officeSupplies),
            Item(id: UUID().uuidString, name: "필기구", theme: .officeSupplies),
            Item(id: UUID().uuidString, name: "노트북", theme: .electronics),
            
            // 전자기기
            Item(id: UUID().uuidString, name: "충전기", theme: .electronics),
            Item(id: UUID().uuidString, name: "멀티어댑터", theme: .electronics),
            Item(id: UUID().uuidString, name: "카메라", theme: .electronics),
            Item(id: UUID().uuidString, name: "셀카봉", theme: .electronics),
            Item(id: UUID().uuidString, name: "보조배터리", theme: .electronics),
            Item(id: UUID().uuidString, name: "케이블", theme: .electronics),
            Item(id: UUID().uuidString, name: "이어폰", theme: .electronics),
            Item(id: UUID().uuidString, name: "스피커", theme: .electronics),
            Item(id: UUID().uuidString, name: "헤어드라이기", theme: .electronics),
            Item(id: UUID().uuidString, name: "고데기", theme: .electronics),
            Item(id: UUID().uuidString, name: "면도기", theme: .electronics),
            
            // 수영용품
            Item(id: UUID().uuidString, name: "수영복", theme: .swimGear),
            Item(id: UUID().uuidString, name: "수영모", theme: .swimGear),
            Item(id: UUID().uuidString, name: "수경", theme: .swimGear),
            Item(id: UUID().uuidString, name: "방수팩", theme: .swimGear),
            Item(id: UUID().uuidString, name: "튜브", theme: .swimGear),
            
            // 골프용품
            Item(id: UUID().uuidString, name: "골프 클럽", theme: .golfGear),
            Item(id: UUID().uuidString, name: "골프공", theme: .golfGear),
            Item(id: UUID().uuidString, name: "골프화", theme: .golfGear),
            
            // 계절용품
            Item(id: UUID().uuidString, name: "장갑", theme: .seasonalItems),
            Item(id: UUID().uuidString, name: "목도리", theme: .seasonalItems),
            Item(id: UUID().uuidString, name: "선글라스", theme: .seasonalItems),
            Item(id: UUID().uuidString, name: "손풍기", theme: .seasonalItems),
            
            // 기타
            Item(id: UUID().uuidString, name: "침낭", theme: .others),
            Item(id: UUID().uuidString, name: "담요", theme: .others),
            Item(id: UUID().uuidString, name: "수건", theme: .others),
            Item(id: UUID().uuidString, name: "우산", theme: .others),
            Item(id: UUID().uuidString, name: "우비", theme: .others),
            Item(id: UUID().uuidString, name: "휴지", theme: .others),
            Item(id: UUID().uuidString, name: "물티슈", theme: .others),
            Item(id: UUID().uuidString, name: "마스크", theme: .others),
            Item(id: UUID().uuidString, name: "샤워기 필터", theme: .others),
            Item(id: UUID().uuidString, name: "인공눈물", theme: .others),
            Item(id: UUID().uuidString, name: "렌즈 보존액", theme: .others),
            Item(id: UUID().uuidString, name: "렌즈 보관 용기", theme: .others),
            Item(id: UUID().uuidString, name: "빗", theme: .others),
            Item(id: UUID().uuidString, name: "머리끈", theme: .others),
            Item(id: UUID().uuidString, name: "목베개", theme: .others),
            Item(id: UUID().uuidString, name: "안대", theme: .others),
            Item(id: UUID().uuidString, name: "지퍼백", theme: .others),
            Item(id: UUID().uuidString, name: "자물쇠", theme: .others),
            Item(id: UUID().uuidString, name: "컵라면", theme: .others),
            Item(id: UUID().uuidString, name: "수저", theme: .others),
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
