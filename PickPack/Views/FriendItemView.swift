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
    
    var body: some View {
        NavigationStack{
            VStack(spacing: 10) {
                // 배열이 비었을 때
                // emptyFriendListView
                
                // 사람이 있다면
                friendRow
                
                friendRow
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .background(.black1)
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
        VStack {
            
        }
    }
    
    private var friendRow: some View {
            HStack(spacing: 0){
                
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 16)
                
                Text("슌")
                    .font(.body)
                
                Spacer()
                
                NavigationLink {
                    FriendItemListView()
                } label: {
                    HStack{
                        Text("짐리스트 보러가기")
                            .font(.subheadline)
                        Image(systemName: "chevron.right")
                        
                    }
                    .foregroundStyle(.black6)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(.white) // 확인용, 나중에 white로
            .cornerRadius(20)
        }
    
}

#Preview {
    FriendItemView()
}
