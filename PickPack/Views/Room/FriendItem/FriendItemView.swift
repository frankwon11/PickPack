//
//  FriendItemsView.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendItemView: View {
    
    // 친구 배열 @Binding or request
    let invitationCode: String = "00342F"
    @Binding var members: [Member]

    
    var body: some View {
        ZStack {
            Color.black1
            
            ScrollView {
                VStack(spacing: 10) {
                    // 배열이 비었을 때
                    if members.isEmpty {
                        emptyFriendListView
                    } else {
                        // 사람이 있다면 FriendListVie 대신 더미 2개
                        friendListView
                    }
                    
                    Spacer()
                }
                .padding(.top, 16)
                .padding(.horizontal, 20)
                .background(.black1)
            }
        }
    }
}

extension FriendItemView {
    
    // MARK: - 친구 리스트가 비어있을 때, 화면
    @ViewBuilder
    private var emptyFriendListView: some View {
        VStack {
            Text("친구를 초대하세요!")
                .foregroundStyle(.black5)
                .font(.title3)
                .padding(.bottom, 20)
            
            Text("초대코드 복사")
                .foregroundStyle(.black5)
                .font(.body)
            
            Button(action: {
                // 복사 기능
                copyTextToClipboard(text: invitationCode)
            }, label: {
                HStack{
                    Text("\(invitationCode)")
                        .font(.body)
                        .foregroundStyle(.blue)
                    
                    Image(systemName: "doc.on.doc.fill")
                        .foregroundStyle(.black4)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(.black2)
                .cornerRadius(12)
                
            })
        }
        .padding(.top, 180)

        
    }
    
    private func copyTextToClipboard(text: String) {
        UIPasteboard.general.string = text
    }
    
    // MARK: - 친구가 있을 때, 화면
    private var friendListView: some View {
        VStack { // 나중에 ForEach
            ForEach($members) { member in
                FriendRow(member: member)
            }
        }
    }

}

#Preview {
        var list = ItemList().items
    
        list[0].isShared = true
        list[1].isShared = true
        list[1].isPacked = true
        list[2].isShared = true
        list[3].isPacked = true
        list[4].isPacked = true
        
    return FriendItemView(members: .constant([
        Member(id: "1234", user: User(id: "14142", name: "슌"), itemList: list, color: .indigo),
        Member(id: "4321", user: User(id: "42421", name: "세이디"), itemList: list, color: .pink)
    ]))
}
