//
//  NetworkManager.swift
//  PickPack
//
//  Created by LDW on 7/24/24.
//

import SwiftUI
import FirebaseDatabase
import FirebaseDatabaseSwift


// MARK: - Firebase(Realtime Database) 통신 매니저
final class NetworkManager {
    
    private var ref: DatabaseReference! = Database.database(url: "https://pickpack-f89b0-default-rtdb.asia-southeast1.firebasedatabase.app").reference()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    static var shared = NetworkManager()
    private init() {}
    
    // MARK: - 데이터베이스에서 데이터 읽기
    func fetchRoomData(roomId: String, completion: @escaping (Room?) -> Void) {
        let roomRef = ref.child("rooms").child(roomId)
        
        roomRef.observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("No data available")
                completion(nil)
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let room = try JSONDecoder().decode(Room.self, from: jsonData)
                completion(room)
            } catch {
                print("Error decoding room: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchMemberData(memberId: String, completion: @escaping (Member?) -> Void) {
        let memberRef = ref.child("members").child(memberId)
        
        memberRef.observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("No data available")
                completion(nil)
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let member = try JSONDecoder().decode(Member.self, from: jsonData)
                completion(member)
            } catch {
                print("Error decoding room: \(error)")
                completion(nil)
            }
        }
    }
    
    func fetchItemListData(roomId: String ,memberId: String, completion: @escaping (Member?) -> Void) {
        let itemListRef = ref.child("itemLists").queryOrdered(byChild: "roomId").queryEqual(toValue: roomId)
        
        itemListRef.observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                print("No data available")
                completion(nil)
                return
            }
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: value)
                let itemList = try JSONDecoder().decode(Member.self, from: jsonData)
                completion(itemList)
            } catch {
                print("Error decoding room: \(error)")
                completion(nil)
            }
        }
    }
    
//    func listenToRealtimeDatabase() {
//        // 데이터베이스를 실시간으로 '관찰'하여 데이터 변경 여부를 확인하여 실시간 데이터 읽기 쓰기
//        
//    }
//    
//    func stopListening() {
//        // 데이터베이스를 실시간으로 '관찰'하는 것을 중지
//        
//    }
    
    // MARK: - 데이터 베이스에 생성 저장
    // 여행 방 생성
    func createNewRoom(room: Room) {
        self.ref?.child("rooms").child("\(room.id)").setValue([
                    "id": room.id,
                    "invitationCode": room.invitationCode,
                    "constructorId": room.constructorId,
                    "name" : room.name,
                    "defaultColor" : room.defaultColor,
                    "startDate1970TimeInterval" : room.startDate1970TimeInterval,
                    "endDate1970TimeInterval" : room.endDate1970TimeInterval,
                    "memberIdList": room.memberIdList,
                    "sharedItemList": room.sharedItemList
        ])
    }

    // 멤버 생성
    func createNewMember(member: Member) {
        self.ref?.child("members").child("\(member.id)").setValue([
            "id": member.id,
            "name": member.name,
            "roomColor": member.roomColor
        ])
    }
    
    // 아이템 리스트 생성
    func createNewItemList(itemList: ItemList) {
        self.ref?.child("itemLists").child("\(itemList.id)").setValue([
            "id": itemList.id,
            "memberId" : itemList.memberId,
            "roomId": itemList.roomId,
            "items": itemList.items
        ])
    }
    
    // 아이템 생성
    func createNewItem(itemListKey: String, item: Item) {
        self.ref?.child("itemLists").child(itemListKey).child("items").child("\(item.id)").setValue([
            "id": item.id,
            "isHidden": item.isHidden,
            "isPacked": item.isPacked,
            "isShared": item.isShared,
            "quantity": item.quantity
        ])
    }
    
    // MARK: - 데이터 베이스에서 데이터 삭제
    // 여행 룸 삭제
    func deleteRoom(key: String) {
        ref?.child("rooms/\(key)").removeValue()
    }
    
    // 멤버 삭제
    func deleteMember(key: String) {
        ref?.child("members/\(key)").removeValue()
    }

    // 아이템 리스트 삭제
    func deleteItemList(key: String) {
        ref?.child("itemLists/\(key)").removeValue()
    }
    
    // 아이템 삭제
    func deleteItem(itemListKey: String, itemKey: String) {
        ref?.child("itemLists/\(itemListKey)/\(itemKey)").removeValue()
    }
    
    // MARK: - 데이터 베이스에서 데이터 수정
    func editRoom(room: Room) {
        
    }
    
}
