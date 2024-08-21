//
//  FirestoreManager.swift
//  MaDang
//
//  Created by LDW on 8/21/24.
//

import Foundation
import FirebaseFirestore

final class FirestoreManager: ObservableObject  {
    @Published var room: Room?
    @Published var members: [Member] = []
    
    private var db = Firestore.firestore()
    private var roomListener: ListenerRegistration?
    private var membersListener: ListenerRegistration?
    
    static let shared = FirestoreManager()
    private init() {}
    
    // 유저 등록(회원가입 시 1회만 실행됨)
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

// MARK: - Create 메서드 모음
extension FirestoreManager {
    // Room 생성 및 Firestore에 저장
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
    
    // 특정 Room에 Member 추가 (하위 컬렉션)
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
    
    // 특정 Room의 SharedItems 하위 컬렉션에 SharedItem 추가
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
    
    // 특정 Room의 특정 Member의 itemList에 Item 추가
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
    
    // 유저의 roomIdList에 roomId 추가
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

// MARK: - Fetch 메서드 모음
extension FirestoreManager {
    // 특정 User의 roomIdList를 이용해 Room 배열 가져오기 (첫 시작 시 사용 예상)
    func fetchRooms(forUser userId: String, completion: @escaping ([Room]) -> Void) {
          fetchUser(byId: userId) { user in
              guard let user = user else {
                  print("Failed to fetch user.")
                  completion([])
                  return
              }
              
              let roomIds = user.roomIdList
              if roomIds.isEmpty {
                  completion([])
                  return
              }
              
              let roomsCollection = self.db.collection("rooms")
              roomsCollection.whereField("id", in: roomIds).getDocuments { (querySnapshot, error) in
                  if let error = error {
                      print("Error fetching rooms: \(error)")
                      completion([])
                      return
                  }
                  
                  let rooms = querySnapshot?.documents.compactMap { document in
                      try? document.data(as: Room.self)
                  } ?? []
                  
                  completion(rooms)
              }
          }
      }
    
    // 특정 Room 데이터 가져오기 (일단 구색 갖추기 위해서)
    func fetchRoom(byId roomId: String, completion: @escaping (Room?) -> Void) {
        let roomRef = db.collection("rooms").document(roomId)
        
        roomRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching room: \(error)")
                completion(nil)
                return
            }
            
            guard let document = document, document.exists, let room = try? document.data(as: Room.self) else {
                print("Room document does not exist or cannot be decoded.")
                completion(nil)
                return
            }
            
            completion(room)
        }
    }
    
    // 특정 Room의 모든 Member 가져오기 (룸에 입장했을 때 요청 예상)
    func fetchMembers(inRoom roomId: String, completion: @escaping ([Member]) -> Void) {
        let membersCollection = db.collection("rooms").document(roomId).collection("members")
        
        membersCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching members: \(error)")
                completion([])
                return
            }
            
            let members = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Member.self)
            } ?? []
            
            completion(members)
        }
    }
    
    // 특정 Room의 모든 SharedItem 가져오기(일단 사용 예상되는 곳은 없음)
    func fetchSharedItems(inRoom roomId: String, completion: @escaping ([SharedItem]) -> Void) {
        let sharedItemsCollection = db.collection("rooms").document(roomId).collection("sharedItems")
        
        sharedItemsCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching shared items: \(error)")
                completion([])
                return
            }
            
            let sharedItems = querySnapshot?.documents.compactMap { document in
                try? document.data(as: SharedItem.self)
            } ?? []
            
            completion(sharedItems)
        }
    }
    
    // 특정 User 데이터 가져오기 (fetchRooms에서 사용)
    func fetchUser(byId userId: String, completion: @escaping (User?) -> Void) {
        let userRef = db.collection("users").document(userId)
        
        userRef.getDocument { (document, error) in
            if let error = error {
                print("Error fetching user: \(error)")
                completion(nil)
                return
            }
            
            guard let document = document, document.exists, let user = try? document.data(as: User.self) else {
                print("User document does not exist or cannot be decoded.")
                completion(nil)
                return
            }
            
            completion(user)
        }
    }
}

// MARK: - Update 메서드 모음
extension FirestoreManager {
    // Room 구조체를 받아서 전체 업데이트
    func updateRoom(_ room: Room) {
        let roomRef = db.collection("rooms").document(room.id)
        
        do {
            try roomRef.setData(from: room) { error in
                if let error = error {
                    print("Error updating room: \(error)")
                } else {
                    print("Room \(room.id) successfully updated.")
                }
            }
        } catch {
            print("Error encoding room: \(error)")
        }
    }
    
    // 특정 Room의 특정 Member 업데이트
    func updateMember(inRoom roomId: String, member: Member) {
        let memberRef = db.collection("rooms").document(roomId).collection("members").document(member.id)
        
        do {
            try memberRef.setData(from: member) { error in
                if let error = error {
                    print("Error updating member \(member.id) in room \(roomId): \(error)")
                } else {
                    print("Member \(member.id) in room \(roomId) successfully updated.")
                }
            }
        } catch {
            print("Error encoding member \(member.id): \(error)")
        }
    }
    
    // 특정 Room의 SharedItem 업데이트
    func updateSharedItem(inRoom roomId: String, sharedItem: SharedItem) {
        let sharedItemRef = db.collection("rooms").document(roomId).collection("sharedItems").document(sharedItem.id)
        
        do {
            try sharedItemRef.setData(from: sharedItem) { error in
                if let error = error {
                    print("Error updating shared item \(sharedItem.id) in room \(roomId): \(error)")
                } else {
                    print("Shared item \(sharedItem.id) in room \(roomId) successfully updated.")
                }
            }
        } catch {
            print("Error encoding shared item \(sharedItem.id): \(error)")
        }
    }
}

extension FirestoreManager {
    // MARK: - Room과 Members를 실시간으로 listen하는 메서드
        func listenToRoomAndMembers(roomId: String, roomCompletion: @escaping (Room?) -> Void, membersCompletion: @escaping ([Member]) -> Void) {
            // 이전에 설정된 listener가 있다면 해제
            roomListener?.remove()
            membersListener?.remove()
            
            // 1. Room 문서에 대한 listener 설정
            let roomRef = db.collection("rooms").document(roomId)
            roomListener = roomRef.addSnapshotListener { documentSnapshot, error in
                if let error = error {
                    print("Error listening to room \(roomId): \(error)")
                    roomCompletion(nil)
                    return
                }
                
                guard let document = documentSnapshot, document.exists, let room = try? document.data(as: Room.self) else {
                    print("Room document does not exist or cannot be decoded.")
                    roomCompletion(nil)
                    return
                }
                
                // 변경된 room 데이터를 반환
                self.room = room
                roomCompletion(room)
            }
            
            // 2. Members 하위 컬렉션에 대한 listener 설정
            let membersCollection = roomRef.collection("members")
            membersListener = membersCollection.addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error listening to members in room \(roomId): \(error)")
                    membersCompletion([])
                    return
                }
                
                let members = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Member.self)
                } ?? []
                
                // 변경된 members 데이터를 반환
                self.members = members
                membersCompletion(members)
            }
        }
        
        // MARK: - 모든 Listener 해제 메서드
        func removeListeners() {
            roomListener?.remove()
            membersListener?.remove()
            roomListener = nil
            membersListener = nil
        }
// MARK: - Room Listener 사용 예시
//    FirestoreManager.shared.listenToRoomAndMembers(
//        roomId: "roomId123",
//        roomCompletion: { room in
//            if let room = room {
//                print("Updated room data: \(room)")
//            } else {
//                print("Failed to retrieve room data or room does not exist.")
//            }
//        },
//        membersCompletion: { members in
//            print("Updated members data: \(members)")
//        }
//    )
//
//    // 필요 시 listener 해제
//    FirestoreManager.shared.removeListeners()
}


