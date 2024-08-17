//
//  FriendSharedList.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendSharedList: View {
    
    @State private var isOpend: Bool = false
    @Binding var itemList: ItemList
    let name: String
    var color: Color = .pink
    
    var body: some View {
        
        let shared = itemList.items.indices.filter { itemList.items[$0].isShared }
        let sharedPacked = itemList.items.indices.filter { itemList.items[$0].isShared && itemList.items[$0].isPacked }
        
        VStack{
            HStack {
                Text("\(name)님이 챙길 공유짐")
                    .font(.callout)
                    .foregroundStyle(color)
                    .padding(.leading, 20)
                
                Spacer()
                
                Text("\(sharedPacked.count)/\(shared.count)")
                    .font(.subheadline)
                    .foregroundStyle(.black5)
                
                Button(action: {
                    withAnimation {
                        isOpend.toggle()
                    }
                }, label: {
                    Image(systemName: "triangleshape.fill")
                        .resizable()
                        .frame(width: 14, height: 10)
                        .rotationEffect(isOpend ? Angle(degrees: 180) : Angle(degrees: 0))
                        .foregroundStyle(.black5)
                })
                .padding(.trailing, 24)
            }
            .padding(.vertical, 8)
            .onAppear { // 더미 삭제
                itemList.items[0].isShared.toggle()
                itemList.items[1].isShared.toggle()
                itemList.items[1].isPacked.toggle()
                itemList.items[2].isShared.toggle()
                itemList.items[3].isPacked.toggle()
                itemList.items[4].isPacked.toggle()
            }
            
            if isOpend {
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(color)
                
                ForEach(shared, id: \.self) { index in
                    FriendItemRowView(item: $itemList.items[index], color: color)
                }
            }
        }
        .padding(.vertical, 8) // 내부 여백 추가
        .background(.white) // 회색 배경 추가
        .cornerRadius(8) // 둥근 모서리 추가
        .padding([.horizontal, .top]) // 외부 여백 추가
    }
}

#Preview {
    FriendSharedList(itemList: .constant(ItemList()), name: "슌")
}
