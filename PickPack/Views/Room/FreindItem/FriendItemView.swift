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
    // 나중에 받아올 것으로 예상되는 정보들,,
    @State private var user1ItemList: ItemList = ItemList()
    @State private var user2ItemList: ItemList = ItemList()
    @State private var user1Name: String = "슌"
    @State private var user2Name: String = "세이디"
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack(spacing: 10) {
                    // 배열이 비었을 때
                    // emptyFriendListView
                    
                    // 사람이 있다면 FriendListVie 대신 더미 2개
                    friendListView
                    
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
        
    }
    
    private func copyTextToClipboard(text: String) {
        UIPasteboard.general.string = text
    }
    
    // MARK: - 친구가 있을 때, 화면
    private var friendListView: some View {
        VStack { // 나중에 ForEach
            FriendRow(itemList: $user1ItemList, name: user1Name)
            FriendRow(itemList: $user2ItemList, name: user2Name)
        }
    }

}

#Preview {
    FriendItemView()
}
