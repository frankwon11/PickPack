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
    // RoomId로 Room 정보 요청
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
    
    // memberId로 Room 정보 요청
    func fetchRoomData(memberId: String, completion: @escaping ([Room]?) -> Void) {
        let userRef = ref.child("members").child(memberId)
        
        userRef.observeSingleEvent(of: .value) { snapshot in
            guard let userData = snapshot.value as? [String: Any],
                  let roomIdList = userData["roomIdList"] as? [String] else {
                print("No rooms found for user")
                completion(nil)
                return
            }
            
            var rooms: [Room] = []
            let group = DispatchGroup()
            
            for roomId in roomIdList {
                group.enter()
                self.ref.child("rooms").child(roomId).observeSingleEvent(of: .value) { roomSnapshot in
                    if let roomData = roomSnapshot.value as? [String: Any] {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: roomData)
                            let room = try JSONDecoder().decode(Room.self, from: jsonData)
                            rooms.append(room)
                        } catch {
                            print("Error decoding room: \(error)")
                        }
                    }
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                completion(rooms)
            }
        }
    }
    
    // memberId로 Member 정보 요청
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
    
    // memberId로 ItemList 정보 요청
    func fetchItemListData(memberId: String, completion: @escaping ([ItemList]?) -> Void) {
            let itemListRef = ref.child("itemLists").queryOrdered(byChild: "memberId").queryEqual(toValue: memberId)
            
            itemListRef.observeSingleEvent(of: .value) { snapshot in
                guard let value = snapshot.value as? [String: [String: Any]] else {
                    print("No data available")
                    completion(nil)
                    return
                }
                
                var matchingItemLists: [ItemList] = []
                
                for (_, itemListData) in value {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: itemListData)
                        let itemList = try JSONDecoder().decode(ItemList.self, from: jsonData)
                        matchingItemLists.append(itemList)
                    } catch {
                        print("Error decoding itemList: \(error)")
                    }
                }
                
                completion(matchingItemLists)
            }
        }
    
    // MARK: - 데이터 베이스에 생성 저장
    // 여행 방 생성
    func createNewRoom(room: Room) {
          self.ref?.child("rooms").child("\(room.id)").setValue(room.toDictionary())
    }

    // 멤버 생성
    func createNewMember(member: Member) {
        self.ref?.child("members").child("\(member.id)").setValue(member.toDictionary())
    }
    
    // 아이템 리스트 생성
    func createNewItemList(itemList: ItemList) {
        self.ref?.child("itemLists").child("\(itemList.id)").setValue(itemList.toDictionary())
    }
    
    // 아이템 생성
    func createNewItem(itemListId: String, item: Item) {
        self.ref?.child("itemLists").child(itemListId).child("items").child("\(item.id)").setValue(item.toDictionary())
    }
    
    // 테스트 필요
    func createNewRoom2(room: Room, memberId: String) {
        let roomData = room.toDictionary()
        self.ref.child("rooms").child(room.id).setValue(roomData)
        
        // 지정된 멤버의 roomIdList에 방 ID 추가
        self.ref.child("members").child(memberId).observeSingleEvent(of: .value) { snapshot in
            if let memberData = snapshot.value as? [String: Any] {
                var member = try? JSONDecoder().decode(Member.self, from: JSONSerialization.data(withJSONObject: memberData))
                member?.roomIdList.append(room.id)
                if let updatedMemberData = member?.toDictionary() {
                    self.ref.child("members").child(memberId).setValue(updatedMemberData)
                }
            } else {
                print("Member not found for ID: \(memberId)")
            }
        }
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
        ref?.child("itemLists/\(itemListKey)/items/\(itemKey)").removeValue()
    }
    
    // MARK: - 데이터 베이스에서 데이터 수정
    func editRoom(room: Room) {
        
    }

    
}

