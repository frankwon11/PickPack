//
//  PickPack.swift
//  PickPack
//
//  Created by LDW on 7/21/24.
//

import SwiftUI

enum RoomColor: String {
    case red
    case blue
    case green
    case yellow
    case purple

    var color: Color {
        switch self {
        case .red:
            return Color.red
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        case .yellow:
            return Color.yellow
        case .purple:
            return Color.purple
        }
    }
}

struct Room {
    let roomId: String = UUID().uuidString // 룸 아이디
    let roomCode: String // 룸 입장코드
    
    var leaderId: String // 리더 멤버 아이디
    var roomName: String // 룸 이름
    var defaultColor: RoomColor = .blue // 방 기본 색상
    var startDate: Date // 여행 시작일
    var endDate: Date // 여행 종료일
    
    var memberList: [Member] = [] // 여행 멤버 리스트
    var sharedList: [SharedItem] = [] // 공유 아이템 리스트
    
    // Date 설정 함수
}

struct Member {
    let userId: String = UUID().uuidString // 유저 아이디
    let userName: String // 유저 이름
    let profileImage: UIImage // 유저 프로필 사진
    let joinedDate: Date
    
    var roomColor: RoomColor
    var myItemList: [MyItem] = []
    
}

struct SharedItem {
    let itemId: String = UUID().uuidString // 아이템 아이디
    
    var sharedMen: [Member] = [] // 공유하는 멤버
    var owner: Member // 아이템을 챙길 사람
}

struct MyItem {
    let itemId: String = UUID().uuidString // 아이템 아이디
    
    var isHidden: Bool // 숨김 여부
    var isPacked: Bool // 챙김 여부
    var isShared: Bool // 공유 여부
    var quantity: Int // 아이템 개수
}
