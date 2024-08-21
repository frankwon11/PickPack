//
//  MyItemRow.swift
//  PickPack
//
//  Created by Lee Sihyeong on 8/21/24.
//

import SwiftUI

struct MyItemRow: View {
    let roomColor: Color
    @Binding var item: Item
    @State var status: ItemStatus = .normal
    
    var body: some View {
        HStack(spacing: 0) {
            // 선택 버튼
            Button {
                item.isPacked.toggle()
            } label: {
                Image(systemName: item.isPacked ? "checkmark.square.fill" : "square")
                    .font(.title3)
                    .foregroundStyle(item.isPacked ? roomColor : .black5)
                    .padding(10)
            }
            .padding(.leading, 8)
            
            Text(item.name)
                .font(.callout)
                .strikethrough(item.isPacked, color: .black)
            
            Spacer()
            
            switch status {
            case .normal:
                EmptyView()
            case .hidden:
                Image(systemName: "eye.slash.fill")
                    .font(.subheadline)
                    .foregroundStyle(.black4)
            
            case .shared:
                Image(systemName: "arrow.2.squarepath")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black4)
            }
            
            Menu {
                Picker("", selection: $status) {
                    Text("선택 안함")
                        .tag(ItemStatus.normal)
                    
                    Divider()
                    
                    Label("shared", systemImage: "arrow.2.squarepath")
                        .tag(ItemStatus.shared)
                    
                    Label("hidden", systemImage: "eye.slash.fill")
                        .tag(ItemStatus.hidden)
                }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.subheadline)
                    .foregroundStyle(.black5)
                    .padding(10)
            }
            .onChange(of: status) {
                switch status {
                case .shared:
                    item.isShared = true
                    item.isHidden = false
                case .hidden:
                    item.isShared = false
                    item.isHidden = true
                case .normal:
                    item.isShared = false
                    item.isHidden = false
                }
            }

        }
        .padding(.vertical, 4)
        .onAppear {
            if item.isShared {
                status = .shared
            } else if item.isHidden {
                status = .hidden
            } else {
                status = .normal
            }
        }
    }
    
    enum ItemStatus: String {
        case shared
        case hidden
        case normal
    }
}

#Preview {
    MyItemRow(roomColor: .indigo, item: .constant(Item(id: UUID().uuidString, name: "hello", theme: .clothing)))
}
