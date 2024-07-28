//
//  PickPack.swift
//  PickPack
//
//  Created by LDW on 7/21/24.
//

import SwiftUI

enum RoomColor: Int {
    case red = 0
    case green = 1
    case teal = 2
    case blue = 3
    case indigo = 4
    case purple = 5
    case pink = 6

    var num: Color {
        switch self {
        case .red:
            return Color.red
        case .green:
            return Color.green
        case .teal:
            return Color.teal
        case .blue:
            return Color.blue
        case .purple:
            return Color.purple
        case .indigo:
            return Color.indigo
        case .pink:
            return Color.pink
        }
    }
}

struct Room: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString // 룸 아이디
    var invitationCode: String // 룸 입장코드
    var constructorId: String // 리더 멤버 아이디
    var name: String // 룸 이름
    var defaultColor: Int = 0 // 방 기본 색상
    var startDate: Double // 여행 시작일
    var endDate: Double // 여행 종료일
    var memberIdList: [String] = [] // 여행 멤버 리스트
    var sharedItemList: [SharedItem] = [] // 공유 아이템 리스트
    
    enum CodingKeys: String, CodingKey {
           case id = "id"
           case invitationCode = "invitationCode"
           case constructorId = "constructorId"
           case name = "name"
           case defaultColor = "defaultColor"
           case startDate = "startDate"
           case endDate = "endDate"
           case memberIdList = "memberIdList"
           case sharedItemList = "sharedItemList"
       }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "invitationCode": invitationCode,
            "constructorId": constructorId,
            "name": name,
            "defaultColor": defaultColor,
            "startDate": startDate,
            "endDate": endDate,
            "memberIdList": memberIdList,
            "sharedItemList": sharedItemList.map { $0.toDictionary() }
        ]
    }
    
    init(id: String = UUID().uuidString, invitationCode: String, constructorId: String, name: String, defaultColor: Int = 0, startDate: Double, endDate: Double, memberIdList: [String] = [], sharedItemList: [SharedItem] = []) {
        self.id = id
        self.invitationCode = invitationCode
        self.constructorId = constructorId
        self.name = name
        self.defaultColor = defaultColor
        self.startDate = startDate
        self.endDate = endDate
        self.memberIdList = memberIdList
        self.sharedItemList = sharedItemList
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        invitationCode = try container.decodeIfPresent(String.self, forKey: .invitationCode) ?? ""
        constructorId = try container.decodeIfPresent(String.self, forKey: .constructorId) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        defaultColor = try container.decodeIfPresent(Int.self, forKey: .defaultColor) ?? 0
        startDate = try container.decodeIfPresent(Double.self, forKey: .startDate) ?? 0.0
        endDate = try container.decodeIfPresent(Double.self, forKey: .endDate) ?? 0.0
        memberIdList = try container.decodeIfPresent([String].self, forKey: .memberIdList) ?? []
        sharedItemList = try container.decodeIfPresent([SharedItem].self, forKey: .sharedItemList) ?? []
    }
}

struct Member: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString // 유저 아이디
    var name: String // 유저 이름
    var roomColor: Int = 0
    var roomIdList: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case roomColor = "roomColor"
        case roomIdList = "roomIdList"
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "roomColor": roomColor,
            "roomIdList": roomIdList
        ]
    }
    
    init(id: String = UUID().uuidString, name: String, roomColor: Int = 0, roomIdList: [String] = []) {
        self.id = id
        self.name = name
        self.roomColor = roomColor
        self.roomIdList = roomIdList
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        roomColor = try container.decodeIfPresent(Int.self, forKey: .roomColor) ?? 0
        roomIdList = try container.decodeIfPresent([String].self, forKey: .roomIdList) ?? []
    }
}

struct SharedItem: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString // 아이템 아이디
    var sharedMemberId: [String] = [] // 공유하는 멤버
    var owner: Member? // 아이템을 챙길 사람
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sharedMemberId = "sharedMemberId"
        case owner = "owner"
    }
    
    func toDictionary() -> [String: Any] {
          return [
              "id": id,
              "sharedMemberId": sharedMemberId,
              "owner": owner?.toDictionary() ?? NSNull()
          ]
    }
    
    init(id: String = UUID().uuidString, sharedMemberId: [String] = [], owner: Member? = nil) {
           self.id = id
           self.sharedMemberId = sharedMemberId
           self.owner = owner
       }
       
       init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
           sharedMemberId = try container.decodeIfPresent([String].self, forKey: .sharedMemberId) ?? []
           owner = try container.decodeIfPresent(Member.self, forKey: .owner)
       }
}

struct Item: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString // 아이템 아이디
    var isHidden: Bool = false // 숨김 여부
    var isPacked: Bool = false // 챙김 여부
    var isShared: Bool = false // 공유 여부
    var quantity: Int = 1 // 아이템 개수
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case isHidden = "isHidden"
        case isPacked = "isPacked"
        case isShared = "isShared"
        case quantity = "quantity"
    }
    
    func toDictionary() -> [String: Any] {
            return [
                "id": id,
                "isHidden": isHidden,
                "isPacked": isPacked,
                "isShared": isShared,
                "quantity": quantity
            ]
    }
    
    init(id: String = UUID().uuidString, isHidden: Bool = false, isPacked: Bool = false, isShared: Bool = false, quantity: Int = 1) {
         self.id = id
         self.isHidden = isHidden
         self.isPacked = isPacked
         self.isShared = isShared
         self.quantity = quantity
     }
     
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        isHidden = try container.decodeIfPresent(Bool.self, forKey: .isHidden) ?? false
        isPacked = try container.decodeIfPresent(Bool.self, forKey: .isPacked) ?? false
        isShared = try container.decodeIfPresent(Bool.self, forKey: .isShared) ?? false
        quantity = try container.decodeIfPresent(Int.self, forKey: .quantity) ?? 1
        }
    
}

struct ItemList: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString // 아이템 리스트 아이디
    var memberId: String // 소유한 멤버 아이디
    var roomId: String // 아이템 리스트가 속한 방
    var items: [Item] = []
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case memberId = "memberId"
        case roomId = "roomId"
        case items = "items"
    }
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "memberId": memberId,
            "roomId": roomId,
            "items": items.map { $0.toDictionary() }
        ]
    }
    
    init(id: String = UUID().uuidString, memberId: String, roomId: String, items: [Item] = []) {
        self.id = id
        self.memberId = memberId
        self.roomId = roomId
        self.items = items
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
               id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
               memberId = try container.decodeIfPresent(String.self, forKey: .memberId) ?? ""
               roomId = try container.decodeIfPresent(String.self, forKey: .roomId) ?? ""
               
               if let itemsDict = try container.decodeIfPresent([String: Item].self, forKey: .items) {
                   self.items = Array(itemsDict.values)
               } else {
                   self.items = []
               }
    }
}
