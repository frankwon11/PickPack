//
//  SharedItemNotYetList.swift
//  PickPack
//
//  Created by 추서연 on 8/22/24.
//

import SwiftUI

struct SharedItemNotYetListView: View {
    let roomColor: Color
    @Binding var itemList: [Item]
    
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
