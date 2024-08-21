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

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                if !myItem.filter({ $0.isShared }).isEmpty {
                    mySharedItemView
                }
                
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
    private var mySharedItemView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .foregroundStyle(.white)
            
            MySharedItemThemeRow(roomColor: roomColor, items: myItem.filter({ $0.isShared }))
        }
        .padding([.horizontal, .bottom], 20)
        .padding(.top, 16)
    }
    
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

struct MySharedItemThemeRow: View {
    let roomColor: Color
    var items: [Item]
    @State private var isExpanded: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .center, spacing: 0) {
                Text("내가 챙길 공유짐")
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
                Button {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
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
                Button {
                    withAnimation {
                        isExpanded.toggle()
                    }
                } label: {
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
                .strikethrough(item.isPacked, color: .black)
            
            Spacer()
            
            switch item.state {
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
            
            // MARK: ellipsis에 뭐 들어갈지 아직 몰라서 임시로 Menu 넣음
            Menu {
                Picker("", selection: $item.state) {
                    Button {
                        item.isShared = false
                        item.isHidden = false
                    } label: {
                        Text("선택 안함")
                    }
                    .tag(itemState.normal)
                    
                    Divider()
                    
                    Button {
                        item.isShared = true
                        item.isHidden = false
                    } label: {
                        Label("shared", systemImage: "arrow.2.squarepath")
                    }
                    .tag(itemState.shared)
                    
                    Button {
                        item.isShared = false
                        item.isHidden = true
                    } label: {
                        Label("hidden", systemImage: "eye.slash.fill")
                    }
                    .tag(itemState.hidden)
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

enum itemState: Codable {
    case shared
    case hidden
    case normal
}
