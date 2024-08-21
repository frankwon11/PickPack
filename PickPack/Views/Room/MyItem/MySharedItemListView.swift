//
//  MySharedItemListView.swift
//  PickPack
//
//  Created by Lee Sihyeong on 8/21/24.
//

import SwiftUI

struct MySharedItemListView: View {
    let roomColor: Color
    @Binding var itemList: [Item]
    @State private var isExpanded: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.white)
            
            VStack(spacing: 0) {
                HStack(alignment: .center, spacing: 0) {
                    Text("내가 챙길 공유짐")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundStyle(roomColor)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    // 선택한 아이템 개수 표시
                    Text("\(selectedItemCount())/\(itemList.filter({ $0.isShared }).count)")
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
                    
                    ForEach($itemList) { $item in
                        if item.isShared {
                            MyItemRow(roomColor: roomColor, item: $item)
                            if item.id != itemList.last?.id {
                                Divider()
                                    .background(.black4)
                            }
                        }
                    }
                }
            }
        }
        .padding([.horizontal, .bottom], 20)
        .padding(.top, 16)
    }
    
    func selectedItemCount() -> Int {
        itemList.filter { $0.isPacked && $0.isShared }.count
    }
}

#Preview {
    NavigationStack {
        RoomView()
    }
}
