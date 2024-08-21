//
//  SharedItemView.swift
//  PickPack
//
//  Created by 추서연 on 8/22/24.
//

import SwiftUI

struct SharedItemView: View {
    // MARK: 방 컬러 받아오기
    private let roomColor: Color = .indigo
    
    @State private var showAddItemSheet: Bool = false
    // MARK: member가 가지고 있는 item 배열
    @State private var myItem: [Item] = [
        .init(id: UUID().uuidString, name: "test0", theme: .clothing, isShared: true),
        .init(id: UUID().uuidString, name: "test1", theme: .clothing),
        .init(id: UUID().uuidString, name: "test2", theme: .clothing),
        .init(id: UUID().uuidString, name: "test3", theme: .documents, isShared: true),
        .init(id: UUID().uuidString, name: "test4", theme: .documents),
        .init(id: UUID().uuidString, name: "test5", theme: .cosmetics),
        .init(id: UUID().uuidString, name: "test6", theme: .medication, isShared: true),
        .init(id: UUID().uuidString, name: "test7", theme: .medication),
        .init(id: UUID().uuidString, name: "test8", theme: .others),
        .init(id: UUID().uuidString, name: "test9", theme: .clothing),
    ]
    
    @State private var mySharedItem: [SharedItem] = [
        SharedItem(
            id: UUID().uuidString,
            name: "샴푸",
            item: Item(
                id: UUID().uuidString,
                name: "샴푸",
                theme: .toiletries,
                isShared: true,
                isHidden: false,
                isPacked: true,
                quantity: 10
            ),
            ownerId: UUID().uuidString,
            sharedMemberIdList: []
        )
    ]


    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
//                if !myItem.filter({ $0.isShared }).isEmpty {
//                    MySharedItemListView(roomColor: roomColor, itemList: $myItem)
//                }
                
                addItemButton
                
                if mySharedItem.isEmpty {
                    emptyItemView
                } else {
                    let themesWithItems = ItemTheme.allCases.filter { theme in
                        !myItem.filter { $0.theme == theme }.isEmpty
                    }
                    
                    VStack(alignment:.leading){
                        
                        HStack{
                            Image(systemName:"xmark")
                                .font(.subheadline)
                                
                            Text("정해지지 않은 공유짐")
                                .font(.subheadline)
                        }
                        .foregroundStyle(.black5)
                        .padding(.horizontal, 36)
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
                }
                
                Spacer()
            }
        }
        .background(.black1)
//        .sheet(isPresented: $showAddItemSheet) {
//            AddItemSheet(isSheetDisplaying: $showAddItemSheet, ticketColor: roomColor)
//        }
    }
}

extension SharedItemView {
    private var addItemButton: some View {
        Button {
            showAddItemSheet = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(myItem.isEmpty ? .white : .clear)
                
                Label("새로운 짐 추가하기", systemImage: "plus")
                    .font(.subheadline)
                // MARK: 방 색깔
                    .foregroundStyle(.indigo)
            }
        }
        .frame(height: 48)
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }
    
    private var emptyItemView: some View {
        return Group{
            ZStack{
                VStack(alignment:.center){
                    Spacer()
                    Text("아직 공유하는 짐이 없어요!")
                        .font(.title3)
                        .padding(.bottom,30)
                    HStack{
                        Text("내 짐 리스트에서")
                        Image(systemName:"ellipsis.circle")
                        Text("를 눌러")
                    }
                    .multilineTextAlignment(.center)
                    .font(.body)
                    .foregroundStyle(.black5)
                    
                    Text("'공유하기'를 선택할 수 있어요!")
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .foregroundStyle(.black5)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        SharedItemView()
    }
}
    
