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

class Room: ObservableObject {
    var roomId: String = UUID().uuidString // 룸 아이디
    var roomCode: String // 룸 입장코드
    
    @Published var leaderId: String // 리더 멤버 아이디
    @Published var roomName: String // 룸 이름
    @Published var defaultColor: RoomColor = .blue // 방 기본 색상
    @Published var startDate: Date // 여행 시작일
    @Published var endDate: Date // 여행 종료일
    
    @Published var memberList: [Member] = [] // 여행 멤버 리스트
    @Published var sharedList: [SharedItem] = [] // 공유 아이템 리스트
    
    init(roomCode: String, leaderId: String, roomName: String, defaultColor: RoomColor, startDate: Date, endDate: Date) {
        self.roomCode = roomCode // 룸 코드 생성 코드
        self.leaderId = leaderId
        self.roomName = roomName
        self.defaultColor = defaultColor
        self.startDate = startDate
        self.endDate = endDate
    }
    
    // 멤버 추가, 삭제, 수정
    func appendMember() {
        objectWillChange.send()
    }
    
    func updateMember() {
        objectWillChange.send()
    }
    
    func deleteMember() {
        objectWillChange.send()
    }
    
    // 공유 아이템 추가, 삭제, 수정
    func appendSharedItem() {
        objectWillChange.send()
    }
    
    func updateSharedItem() {
        objectWillChange.send()
    }
    
    func deleteSharedItem() { // 아직 의문
        objectWillChange.send()
    }
    
    // 방 정보 변경
    func updateRoomInfo() {
        objectWillChange.send()
    }
    
}

class Member: ObservableObject, Identifiable {
    var userId: String = UUID().uuidString // 유저 아이디
    let joinedDate: Date
    
    @Published var userName: String // 유저 이름
    @Published var profileImage: UIImage // 유저 프로필 사진
    @Published var roomColor: RoomColor
    @Published var myItemList: [MyItem] = []
    
    init(userName: String, profileImage: UIImage, joinedDate: Date, roomColor: RoomColor, myItemList: [MyItem]) {
        self.userName = userName
        self.profileImage = profileImage
        self.joinedDate = joinedDate
        self.roomColor = roomColor
        self.myItemList = myItemList
    }
    
    // 아이템 추가, 삭제, 수정
    func appendItem() {
        objectWillChange.send()
    }
    
    func deleteItem() {
        objectWillChange.send()
    }
    
    func updateItem(){
        objectWillChange.send()
    }
    
    // 멤버 정보 변경
    func updateMemberInfo() {
        objectWillChange.send()
    }
    
}

class SharedItem: ObservableObject, Identifiable {
    var itemId: String = UUID().uuidString // 아이템 아이디
    
    @Published var sharedMen: [Member] = [] // 공유하는 멤버
    @Published var owner: Member? // 아이템을 챙길 사람
    
    init() {}
    
    // 공유하는 멤버 추가, 삭제
    func appendMember() {
        objectWillChange.send()
    }
    
    func deleteMember() {
        objectWillChange.send()
    }
    
    // 챙길 사람 설정
    func setOwner() {
        objectWillChange.send()
    }
}

class MyItem: ObservableObject, Identifiable {
    let itemId: String = UUID().uuidString // 아이템 아이디
    
    @Published var isHidden: Bool = false // 숨김 여부
    @Published var isPacked: Bool = false // 챙김 여부
    @Published var isShared: Bool = false // 공유 여부
    @Published var quantity: Int = 1 // 아이템 개수
    
    init() {}
    
    convenience init(quantity: Int){
        self.init()
        self.quantity = quantity
    }
    
    // 아이템 상태 설정
    func setMyItem() {
        objectWillChange.send()
    }
}
