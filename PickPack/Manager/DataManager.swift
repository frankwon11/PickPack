//
//  DataManager.swift
//  PickPack
//
//  Created by LDW on 7/21/24.
//

import SwiftUI

@MainActor
final class DataManager {
    @Published var roomList: [Room] = []
    
    static let shared = DataManager()
    private init() {}
}

// MARK: - Room 데이터 조작
extension DataManager {
    // 여행 룸 추가, 삭제
    func appendRoom() {
        
    }
    
    func deleteRoom() {
        
    }
}

// MARK: - Firebase 통신
extension DataManager {
    // 여행룸 정보 요청
    func fetchRoomData() {
        
    }
    
    // 방에 입장, 초대 코드 입력
    func joinRoom() {
        
    }
    
    // 아이템 리스트 세팅, 세이브 버튼
    func setItemList() {
        
    }
    
    // 공유짐 선택, 실시간 반영 필요
    func pickSharedItem() {
        
    }
    

}
