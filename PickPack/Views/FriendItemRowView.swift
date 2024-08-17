//
//  FriendItemRowView.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendItemRowView: View {
    @Binding var item: Item
    
    var body: some View {
        HStack {
            
            HStack {
                Image(systemName: item.isPacked ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(item.isPacked ? .blue : .gray)
            }

            
            Text(item.name)
                .strikethrough(item.isPacked, color: .black)
            
            Spacer()
        }
    }
}

#Preview {
    FriendItemRowView(item: .constant(Item(id: "ddd", name: "fiendf", theme: .documents)))
}
