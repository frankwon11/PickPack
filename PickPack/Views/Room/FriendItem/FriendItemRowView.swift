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
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(item.isPacked ? color : .gray)
                .padding(.trailing, 8)
            
            Text(item.name)
                .strikethrough(item.isPacked, color: .black)
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    FriendItemRowView(item: Item(id: "ddd", name: "fiendf", theme: .documents), color: .blue)
}
