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
        .init(id: UUID().uuidString, name: "test0", theme: .clothing),
        .init(id: UUID().uuidString, name: "test1", theme: .clothing),
        .init(id: UUID().uuidString, name: "test2", theme: .clothing),
        .init(id: UUID().uuidString, name: "test3", theme: .documents),
        .init(id: UUID().uuidString, name: "test4", theme: .documents),
        .init(id: UUID().uuidString, name: "test5", theme: .cosmetics),
        .init(id: UUID().uuidString, name: "test6", theme: .medication),
        .init(id: UUID().uuidString, name: "test7", theme: .medication),
        .init(id: UUID().uuidString, name: "test8", theme: .others),
        .init(id: UUID().uuidString, name: "test9", theme: .clothing),
    ]

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                addItemButton
                
                if myItem.isEmpty {
                    emptyItemView
                } else {
                    notEmptyItemView
                }
                
                Spacer()
            }
        }
        .background(.black1)
        .sheet(isPresented: $showAddItemSheet) {
            AddItemSheet(isSheetDisplaying: $showAddItemSheet, ticketColor: roomColor)
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
                // MARK: 방 색깔
                    .foregroundStyle(.indigo)
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
    
    private var notEmptyItemView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.white)
            
            VStack(spacing: 0) {
                ForEach(ItemTheme.allCases, id: \.self) { theme in
                    let firstTheme = ItemTheme.firstMatchingTheme(items: myItem)
                    let filteredItems = myItem.filter { $0.theme == theme }
                    
                    if !filteredItems.isEmpty {
                        MyItemThemeRow(roomColor: roomColor, theme: theme, items: filteredItems, isFirst: firstTheme == theme)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct MyItemThemeRow: View {
    let roomColor: Color
    var theme: ItemTheme
    var items: [Item]
    let isFirst: Bool
    @State private var isExpanded: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
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
                Text("\(selectedItemCount())/\(items.count)")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(.black5)
                
                // 토글 버튼
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "triangle.fill" : "triangle.fill")
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
                ForEach(items) { item in
                    MyItemRow(roomColor: roomColor, item: item)
                    
                    if items.last?.id != item.id {
                        Divider()
                            .background(.black4)
                    }
                }
            }
        }
    }
    
    func selectedItemCount() -> Int {
        items.filter { $0.isPacked }.count
    }
}

struct MyItemRow: View {
    let roomColor: Color
    @State var item: Item
    
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
            
            Spacer()
            
            if item.isHidden {
                Image(systemName: "eye.slash.fill")
                    .font(.subheadline)
                    .foregroundStyle(.black4)
            } else if item.isShared {
                Image(systemName: "arrow.2.squarepath")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black4)
            }
            
            // MARK: ellipsis에 뭐 들어갈지 아직 몰라서 임시로 Menu 넣음
            Menu {
                Button {
                    item.isHidden.toggle()
                } label: {
                    Text("hidden")
                }
                Button {
                    item.isShared.toggle()
                } label: {
                    Text("share")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .font(.subheadline)
                    .foregroundStyle(.black5)
                    .padding(10)
            }

        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        RoomView()
    }
}
