//
//  FirestoreManager.swift
//  MaDang
//
//  Created by LDW on 8/21/24.
//

import Foundation
import FirebaseFirestore

final class FirestoreManager: ObservableObject  {
    @Published var reviews: [Room] = []
    
    private var db = Firestore.firestore()
    
    static let shared = FirestoreManager()
    private init() {}
    
    // MARK: - 유저 등록(회원가입 시 1회만 실행됨)
    func addUser(id: String, name: String) {
        let usersCollection = db.collection("users")
        
        // 같은 ID가 있는지 확인하는 쿼리
        usersCollection.whereField("id", isEqualTo: id).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error checking for existing user: \(error)")
                return
            }
            
            if let documents = querySnapshot?.documents, !documents.isEmpty {
                // 이미 같은 ID를 가진 유저가 있는 경우, 상태 메세지 출력
                print("User with id \(id) already exists.")
            } else {
                // 같은 ID를 가진 유저가 없는 경우, 새로 추가
                let newUser = User(id: id, name: name, roomIdList: [])
                
                do {
                    let _ = try usersCollection.addDocument(from: newUser)
                    print("User added with id \(id)")
                } catch {
                    print("Error adding user: \(error)")
                }
            }
        }
    }
}

// MARK: - Create Data
extension FirestoreManager {
    // MARK: - Room 생성 및 Firestore에 저장
    func createRoom(id: String, code: String, startDate: Date, endDate: Date, name: String, color: CustomColor, userId: String) {
        let roomData: [String: Any] = [
            "id": id,
            "code": code,
            "startDate": startDate,
            "endDate": endDate,
            "name": name,
            "color": color.rawValue
        ]
        
        let roomRef = db.collection("rooms").document(id)
        
        roomRef.setData(roomData) { error in
            if let error = error {
                print("Error adding room: \(error.localizedDescription)")
            } else {
                print("Room added with ID: \(id)")
                // 방 생성 후 유저의 roomIdList에 추가
                self.addRoomToUser(userId: userId, roomId: id)
            }
        }
    }
    
    // MARK: - 특정 Room에 Member 추가 (하위 컬렉션)
    func addMember(toRoom roomId: String, member: Member) {
        let roomRef = db.collection("rooms").document(roomId)
        let membersCollection = roomRef.collection("members")
        
        do {
            let _ = try membersCollection.document(member.id).setData(from: member)
            print("Member added with ID: \(member.id) to room \(roomId)")
            // 멤버 추가 후 유저의 roomIdList에 추가
            self.addRoomToUser(userId: member.user.id, roomId: roomId)
        } catch {
            print("Error adding member: \(error)")
        }
    }
    
    // MARK: - 특정 Room의 SharedItems 하위 컬렉션에 SharedItem 추가
    func addSharedItem(toRoom roomId: String, sharedItem: SharedItem) {
        let roomRef = db.collection("rooms").document(roomId)
        let sharedItemsCollection = roomRef.collection("sharedItems")
        
        do {
            let _ = try sharedItemsCollection.document(sharedItem.id).setData(from: sharedItem)
            print("Shared item added with ID: \(sharedItem.id) to room \(roomId)")
        } catch {
            print("Error adding shared item: \(error)")
        }
    }
    
    // MARK: - 특정 Room의 특정 Member의 itemList에 Item 추가
    func addItem(toRoom roomId: String, forMember memberId: String, item: Item) {
        let roomRef = db.collection("rooms").document(roomId)
        let memberRef = roomRef.collection("members").document(memberId)
        
        memberRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching member document: \(error)")
                return
            }
            
            guard let document = document, document.exists, var member = try? document.data(as: Member.self) else {
                print("Member document does not exist or cannot be decoded.")
                return
            }
            
            member.itemList.append(item)
            
            do {
                try memberRef.setData(from: member)
                print("Item added to member \(memberId) in room \(roomId).")
            } catch {
                print("Error updating member document: \(error)")
            }
        }
    }
    
    // MARK: - 유저의 roomIdList에 roomId 추가
    private func addRoomToUser(userId: String, roomId: String) {
        let userRef = db.collection("users").document(userId)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching user document: \(error)")
                return
            }
            
            guard let document = document, document.exists, var user = try? document.data(as: User.self) else {
                print("User document does not exist or cannot be decoded.")
                return
            }
            
            if !user.roomIdList.contains(roomId) {
                user.roomIdList.append(roomId)
                
                do {
                    try userRef.setData(from: user)
                    print("Room ID \(roomId) added to user \(userId)'s roomIdList.")
                } catch {
                    print("Error updating user document: \(error)")
                }
            } else {
                print("Room ID \(roomId) already exists in user \(userId)'s roomIdList.")
            }
        }
    }
}
