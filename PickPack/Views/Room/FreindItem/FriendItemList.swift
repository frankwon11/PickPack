//
//  FriendItemList.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendItemList: View {
    
    @State private var isOpend: Bool = false
    @Binding var itemList: ItemList
    let itemTheme: ItemTheme
    let color: Color
    let isLastRow: Bool
    
    var body: some View {
        
        let friendItems = itemList.items.indices.filter { !itemList.items[$0].isShared &&
            itemList.items[$0].theme == itemTheme
        }
        
        let friendItemsPacked = itemList.items.indices.filter { !itemList.items[$0].isShared &&
            itemList.items[$0].isPacked  &&
            itemList.items[$0].theme == itemTheme
        }
        
        VStack{
            HStack {
                Text("\(itemTheme.rawValue)")
                    .font(.callout)
                    .foregroundStyle(color)
                    .padding(.leading, 20)
                
                Spacer()
                
                Text("\(friendItemsPacked.count)/\(friendItems.count)")
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
                    FriendItemRowView(item: $itemList.items[friendItems[index]], color: color)
                        .padding(.leading, 20)

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
//
//#Preview {
//    FriendItemList(itemTheme: .clothing, color: .pink)
//}
