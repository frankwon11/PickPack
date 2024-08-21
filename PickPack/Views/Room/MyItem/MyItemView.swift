//
//  MyItemView.swift
//  PickPack
//
//  Created by Lee Sihyeong on 8/17/24.
//

import SwiftUI

struct MyItemView: View {
    // MARK: 방 컬러 받아오기
    private let roomColor: Color = .indigo
    
    @State private var showAddItemSheet: Bool = false
    // MARK: member가 가지고 있는 item 배열
    @State private var myItem: [Item] = [
//        .init(id: UUID().uuidString, name: "test0", theme: .clothing, isShared: true),
//        .init(id: UUID().uuidString, name: "test1", theme: .clothing),
//        .init(id: UUID().uuidString, name: "test2", theme: .clothing),
//        .init(id: UUID().uuidString, name: "test3", theme: .documents, isShared: true),
//        .init(id: UUID().uuidString, name: "test4", theme: .documents),
//        .init(id: UUID().uuidString, name: "test5", theme: .cosmetics),
//        .init(id: UUID().uuidString, name: "test6", theme: .medication, isShared: true),
//        .init(id: UUID().uuidString, name: "test7", theme: .medication),
//        .init(id: UUID().uuidString, name: "test8", theme: .others),
//        .init(id: UUID().uuidString, name: "test9", theme: .clothing),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if !myItem.filter({ $0.isShared }).isEmpty {
                    MySharedItemListView(roomColor: roomColor, itemList: $myItem)
                }
                
                addItemButton
                
                if myItem.isEmpty {
                    emptyItemView
                } else {
                    let themesWithItems = ItemTheme.allCases.filter { theme in
                        !myItem.filter { $0.theme == theme }.isEmpty
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            ForEach(themesWithItems.indices, id: \.self) { index in
                                MyItemListView(theme: themesWithItems[index], roomColor: roomColor, itemList: $myItem, isFirst: index == themesWithItems.indices.first)
                            }
                        }
                    }
                }
                
                Spacer()
            }
        }
        .background(.black1)
        .sheet(isPresented: $showAddItemSheet) {
            AddItemSheet(items: $myItem, isSheetDisplaying: $showAddItemSheet, roomColor: roomColor)
        }
    }
}

extension MyItemView {
    private var addItemButton: some View {
        Button {
            showAddItemSheet = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(myItem.isEmpty ? .white : .clear)
                
                Label("새로운 짐 추가하기", systemImage: "plus")
                    .font(.subheadline)
                    .foregroundStyle(roomColor)
            }
        }
        .frame(height: 48)
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
    
    private var emptyItemView: some View {
        Text("새로운 짐을 추가하여\n짐 싸기를 시작해보세요!")
            .multilineTextAlignment(.center)
            .font(.title3)
            .foregroundStyle(.black5)
            .padding(.top, 180)
    }
}

#Preview {
    NavigationStack {
        RoomView()
    }
}
    
