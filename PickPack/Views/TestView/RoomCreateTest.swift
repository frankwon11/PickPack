//
//  RoomCreateTest.swift
//  PickPack
//
//  Created by LDW on 8/22/24.
//

import SwiftUI

struct RoomCreateTest: View {
    @StateObject private var firestoreManager = FirestoreManager.shared
    
    @State private var roomId: String = UUID().uuidString
    @State private var memberId: String = UUID().uuidString
    @State private var sharedItemId: String = UUID().uuidString
    
    var body: some View {
        VStack(spacing: 20) {
            Text("FirestoreManager Test")
                .font(.largeTitle)
                .padding()
            
            // Room 생성 및 저장 테스트
            Button(action: {
                createRoomTest()
            }) {
                Text("Create Room")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            // Member 추가 테스트
            Button(action: {
                addMemberTest()
            }) {
                Text("Add Member")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8)
            }
            
            // Shared Item 추가 테스트
            Button(action: {
                addSharedItemTest()
            }) {
                Text("Add Shared Item")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.orange)
                    .cornerRadius(8)
            }
            
            // 특정 Member의 ItemList에 Item 추가 테스트
            Button(action: {
                addItemToMemberTest()
            }) {
                Text("Add Item to Member")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.purple)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
    
    // Room 생성 및 저장 테스트 메서드
    private func createRoomTest() {
        firestoreManager.createRoom(
            id: roomId,
            code: "ROOM123",
            startDate: Date(),
            endDate: Calendar.current.date(byAdding: .day, value: 7, to: Date()) ?? Date(),
            name: "Holiday Trip",
            color: .blue
        )
    }
    
    // Member 추가 테스트 메서드
    private func addMemberTest() {
        let newMember = Member(
            id: memberId,
            user: User(id: UUID().uuidString, name: "Alice"),
            itemList: [],
            color: .green
        )
        firestoreManager.addMember(toRoom: roomId, member: newMember)
    }
    
    // Shared Item 추가 테스트 메서드
    private func addSharedItemTest() {
        let newSharedItem = SharedItem(
            id: sharedItemId,
            name: "Tripod",
            item: Item(id: UUID().uuidString, name: "Tripod", theme: .electronics),
            ownerId: memberId,
            sharedMemberIdList: [UUID().uuidString]
        )
        firestoreManager.addSharedItem(toRoom: roomId, sharedItem: newSharedItem)
    }
    
    // 특정 Member의 ItemList에 Item 추가 테스트 메서드
    private func addItemToMemberTest() {
        let newItem = Item(id: UUID().uuidString, name: "Laptop", theme: .electronics)
        firestoreManager.addItem(toRoom: roomId, forMember: memberId, item: newItem)
    }
}

#Preview {
    RoomCreateTest()
}
