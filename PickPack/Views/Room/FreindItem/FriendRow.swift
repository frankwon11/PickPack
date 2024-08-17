//
//  FriendRow.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendRow: View {
    
    @Binding var itemList: ItemList
    let name: String
    
    var body: some View {
        HStack(spacing: 0){
            
            Image(systemName: "person.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .padding(.trailing, 16)
            
            Text(name)
                .font(.body)
            
            Spacer()
            
            NavigationLink {
                FriendItemListView(itemList: $itemList, name: name)
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

//#Preview {
//    FriendRow()
//}
