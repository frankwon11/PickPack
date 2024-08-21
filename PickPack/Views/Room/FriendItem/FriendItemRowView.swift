//
//  FriendItemRowView.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendItemRowView: View {
    let item: Item
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: item.isPacked ? "checkmark.square.fill" : "square")
                .font(.title3)
                .foregroundColor(item.isPacked ? color : .gray)
                .padding(.trailing, 8)
            
            Text(item.name)
                .font(.callout)
            
            Spacer()
        }
        .padding(.leading, 20)
        .padding(.vertical, 8)
    }
}

#Preview {
    FriendItemRowView(item: Item(id: "ddd", name: "fiendf", theme: .documents), color: .blue)
}
