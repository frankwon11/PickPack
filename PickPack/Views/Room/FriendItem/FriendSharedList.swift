//
//  FriendSharedList.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendSharedList: View {
    
    @State private var isOpend: Bool = false
    @Binding var member: Member
    
    var body: some View {
//
//        let shared = member.itemList.indices.filter { member.itemList[$0].isShared }
//        let sharedPacked = member.itemList.indices.filter { member.itemList[$0].isShared && member.itemList[$0].isPacked }

        VStack{
            let shared = member.itemList.filter { $0.isShared }
            let sharedPacked = shared.filter { $0.isPacked }
            
            HStack {
                Text("\(member.user.name)님이 챙길 공유짐")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(member.color.color)
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
            
            if isOpend {
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(member.color.color)
                
                ForEach(shared, id: \.self) { item in
                    FriendItemRowView(item: item, color: member.color.color)
                    if let lastItem = shared.last {
                        if item.id != lastItem.id{
                            Divider()
                                .background(.black4)
                        }
                    }
                }
            }
        }
        .padding(.vertical, 8) // 내부 여백 추가
        .background(.white) // 회색 배경 추가
        .cornerRadius(8) // 둥근 모서리 추가
        .padding([.horizontal, .top]) // 외부 여백 추가
    }
}

//#Preview {
//    FriendSharedList(itemList: .constant(ItemList().items), name: "슌")
//}
