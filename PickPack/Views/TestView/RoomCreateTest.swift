//
//  RoomCreateTest.swift
//  PickPack
//
//  Created by LDW on 8/22/24.
//

import SwiftUI

struct RoomCreateTest: View  {
    @StateObject private var firestoreManager = FirestoreManager.shared
    
    // Room 및 Member 정보를 위한 상태 변수
    @State private var roomName: String = "Vacation Room"
    @State private var roomColor: CustomColor = .blue
    @State private var memberName: String = "John Doe"
    @State private var userId: String = "userId123"
    @State private var roomId: String = UUID().uuidString
    @State private var selectedMemberId: String?
    
    @State private var fetchedRoom: Room?
    @State private var fetchedMembers: [Member] = []
    
    // Listen 상태를 추적하기 위한 상태 변수
    @State private var isListening: Bool = false
    
    // Item 추가를 위한 상태 변수
    @State private var newItemName: String = "New Item"
    
    var body: some View {
        VStack(spacing: 20) {
            // Room 생성 버튼
            Button("Create Room") {
                let startDate = Date()
                let endDate = Calendar.current.date(byAdding: .day, value: 7, to: startDate)!
                firestoreManager.createRoom(id: roomId, code: "ROOM2024", startDate: startDate, endDate: endDate, name: roomName, color: roomColor, userId: userId)
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            // Member 추가 버튼
            Button("Add Member to Room") {
                let memberId = UUID().uuidString
                let member = Member(id: memberId, user: User(id: userId, name: memberName), itemList: [], color: .green)
                firestoreManager.addMember(toRoom: roomId, member: member)
                selectedMemberId = memberId
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            // Room 및 Member 정보 가져오기 버튼
            Button("Fetch Room and Members") {
                firestoreManager.fetchRoom(byId: roomId) { room in
                    self.fetchedRoom = room
                }
                
                firestoreManager.fetchMembers(inRoom: roomId) { members in
                    self.fetchedMembers = members
                }
            }
            .padding()
            .background(Color.orange)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            // Room 및 Members 실시간 업데이트 Listen 버튼
            Button(isListening ? "Stop Listening to Room and Members" : "Listen to Room and Members") {
                if isListening {
                    firestoreManager.removeListeners()
                    isListening = false
                } else {
                    firestoreManager.listenToRoomAndMembers(roomId: roomId) { room in
                        self.fetchedRoom = room
                    } membersCompletion: { members in
                        self.fetchedMembers = members
                    }
                    isListening = true
                }
            }
            .padding()
            .background(isListening ? Color.red : Color.purple)
            .foregroundColor(.white)
            .cornerRadius(8)
            
            // 특정 Member의 itemList에 Item 추가 버튼
            if let memberId = selectedMemberId {
                Button("Add Item to Member's Item List") {
                    let newItem = Item(id: UUID().uuidString, name: newItemName, theme: .essentials)
                    firestoreManager.addItem(toRoom: roomId, forMember: memberId, item: newItem)
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            
            // Room 정보 표시
            if let fetchedRoom = fetchedRoom {
                Text("Room Name: \(fetchedRoom.name)")
                Text("Room Color: \(fetchedRoom.color.rawValue)")
                Text("Room Code: \(fetchedRoom.code)")
            }
            
            // Member 정보 표시
            List(fetchedMembers) { member in
                VStack(alignment: .leading) {
                    Text("Member Name: \(member.user.name)")
                    Text("Member Color: \(member.color.rawValue)")
                    
                    // Member의 itemList 표시
                    ForEach(member.itemList) { item in
                        Text("- \(item.name) (\(item.theme.rawValue))")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    RoomCreateTest()
}
