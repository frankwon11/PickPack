//
//  MyItemListView.swift
//  PickPack
//
//  Created by Lee Sihyeong on 8/21/24.
//

import SwiftUI

struct MyItemListView: View {
    let theme: ItemTheme
    let roomColor: Color
    @Binding var itemList: [Item]
    @State private var isExpanded: Bool = false
    let isFirst: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            if !isFirst {
                Divider()
                    .background(roomColor)
            }
            
            HStack(alignment: .center, spacing: 0) {
                Text(theme.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(roomColor)
                    .padding(.leading, 20)
                
                Spacer()
                
                // 선택한 아이템 개수 표시
                Text("\(selectedItemCount())/\(itemList.filter({ $0.theme == theme}).count)")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(.black5)
                
                // 토글 버튼
                Button {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
                    Image(systemName: "triangle.fill")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.black5)
                        .padding(16)
                        .rotationEffect(isExpanded ? .zero : .degrees(180))
                }
            }
            
            if isExpanded {
                Divider()
                    .background(roomColor)
                
                let lastItem = itemList.last(where: { $0.theme == theme })
                
                ForEach($itemList) { $item in
                    if item.theme == theme {
                        MyItemRow(roomColor: roomColor, item: $item)
                        
                        if item.id != lastItem?.id {
                            Divider()
                                .background(.black4)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    func selectedItemCount() -> Int {
        itemList.filter { $0.isPacked && $0.theme == theme }.count
    }
}

#Preview {
    NavigationStack {
        RoomView()
    }
}
