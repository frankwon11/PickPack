//
//  FriendRow.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendRow: View {
    
    @Binding var member: Member
    
    var body: some View {
        NavigationLink {
            FriendItemListView(member: $member)
        } label: {
            HStack(spacing: 0){
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(member.color.color)
                    .frame(width: 40, height: 40)
                    .padding(.trailing, 16)
                
                Text(member.user.name)
                    .font(.body)
                
                Spacer()
                HStack{
                    Text("짐리스트 보러가기")
                        .font(.subheadline)
                    Image(systemName: "chevron.right")
                    
                }
                .foregroundStyle(.black6)
            }
        }
        .tint(.black)
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(.white) // 확인용, 나중에 white로
        .cornerRadius(20)
        //        .onAppear {
        //            member.itemList[0].isShared = true
        //            member.itemList[1].isShared = true
        //            member.itemList[1].isPacked = true
        //            member.itemList[2].isShared = true
        //            member.itemList[3].isPacked = true
        //            member.itemList[4].isPacked = true
        //
        //            print("\n")
        //
        //            print("memeber item state")
        //            print("member.itemList[0].isPacked : \(member.itemList[0].isPacked)")
        //            print("member.itemList[0].isShared : \(member.itemList[0].isShared)")
        //
        //            print("member.itemList[1].isPacked : \(member.itemList[1].isPacked)")
        //            print("member.itemList[1].isShared : \(member.itemList[1].isShared)")
        //        }
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

    return FriendRow(member: .constant( Member(id: "1234", user: User(id: "14142", name: "슌"), itemList: list, color: .indigo)))
}
