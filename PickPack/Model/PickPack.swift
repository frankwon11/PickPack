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
    var startDate1970TimeInterval: String // 여행 시작일
    var endDate1970TimeInterval: String // 여행 종료일
    var memberIdList: [String] = [] // 여행 멤버 리스트
    var sharedItemList: [SharedItem] = [] // 공유 아이템 리스트
    
    enum CodingKeys: String, CodingKey {
           case id = "id"
           case invitationCode = "code"
           case constructorId = "constructorId"
           case name = "name"
           case defaultColor = "defaultColor"
           case startDate1970TimeInterval = "startDate1970TimeInterval"
           case endDate1970TimeInterval = "endDate1970TimeInterval"
           case memberIdList = "memberIdList"
           case sharedItemList = "sharedItemList"
       }
}

struct Member: Codable, Identifiable, Hashable {
    var id: String = UUID().uuidString // 유저 아이디
    var name: String // 유저 이름
    var roomColor: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case roomColor = "roomColor"
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
}
