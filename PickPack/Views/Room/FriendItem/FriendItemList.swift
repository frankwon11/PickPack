//
//  FriendItemList.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendItemList: View {
    
    @State private var isOpend: Bool = false
    @Binding var itemList: [Item]
    let itemTheme: ItemTheme
    let color: Color
    let isLastRow: Bool
    
    var body: some View {
        
        let friendItems = itemList.indices.filter { !itemList[$0].isShared &&
            itemList[$0].theme == itemTheme
        }
        
        let friendItemsPacked = itemList.indices.filter { !itemList[$0].isShared &&
            itemList[$0].isPacked  &&
            itemList[$0].theme == itemTheme
        }
        
        VStack{
            HStack {
                Text("\(itemTheme.rawValue)")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(color)
                    .padding(.leading, 20)
                
                Spacer()
                
                Text("\(friendItemsPacked.count)/\(friendItems.count)")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(.black5)
                
                Button(action: {
                    withAnimation {
                        isOpend.toggle()
                    }
                }, label: {
                    Image(systemName: "triangleshape.fill")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .rotationEffect(isOpend ? Angle(degrees: 180) : Angle(degrees: 0))
                        .foregroundStyle(.black5)
                })
                .padding(.trailing, 24)
            }
            .padding(.vertical, 8)
            
            if !isLastRow {
                Rectangle()
                    .frame(height: 1)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(color)
            }
            
            if isOpend {
                if isLastRow {
                    Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(color)
                }
                
                ForEach(friendItems.indices, id: \.self) { index in
                    FriendItemRowView(item: itemList[friendItems[index]], color: color)

                    if index != friendItems.indices.last {
                        Rectangle()
                            .frame(height: 1)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.black4)
                    }
                }
                
                if !isLastRow {
                    Rectangle()
                        .frame(height: 1)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(color)
                }
                
            }
        }

        
    }
}

//#Preview {
//    FriendItemList(itemList: .constant(ItemList()), itemTheme: .clothing, color: ., isLastRow: <#T##Bool#>)
//}
