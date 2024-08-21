//
//  AddItemSheet.swift
//  PickPack
//
//  Created by sseungwonnn on 8/16/24.
//

import SwiftUI

struct AddItemSheet: View {
    // TODO: 상위 뷰에서 State로 넘겨주고, Binding으로 받아서 사용.
//    /*@Binding */var itemList: ItemList = ItemList()
    @State private var itemList: ItemList = ItemList()
    @Binding var items: [Item]
    @Binding var isSheetDisplaying: Bool
    
    var roomColor: Color
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 20)
                        
                        VStack(spacing: 0) {
                            ForEach(filteredThemes(), id: \.self) { theme in
                                ThemeRow(theme: theme, items: itemList.filterItems(by: theme))
                            }
                        }
                    }
                }
                
                Spacer()
                
                // TODO: sheet 만들어야됨
                NavigationLink {
                    CustomItemAddView(itemList: $itemList, roomColor: roomColor)
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .foregroundStyle(.white)
                        
                        HStack{
                            Text("사용자정의 짐 추가하기")
                                .font(.subheadline)
                                .foregroundStyle(roomColor)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.callout)
                                .foregroundStyle(roomColor)
                        }
                        .padding(.horizontal, 24)
                    }
                }
                .frame(height: 50)
                .padding(.horizontal, 20)
            }
            .background(.black1)
            .searchable(text: $searchText, prompt: "검색할 항목을 입력하세요")
            .navigationTitle("새로운 짐 추가하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isSheetDisplaying = false
                    }) {
                        Text("취소")
                            .foregroundStyle(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // TODO: 완료 버튼 동작 추가
                        isSheetDisplaying = false
                    }) {
                        Text("완료")
                            .foregroundStyle(roomColor)
                    }
                }
            }
        }
    }
    
    func filteredThemes() -> [ItemTheme] {
        let allThemes = ItemTheme.allCases
        if searchText.isEmpty {
            return allThemes
        } else {
            let filteredItems = itemList.items.filter { $0.name.contains(searchText) }
            let filteredThemes = Set(filteredItems.map { $0.theme })
            return allThemes.filter { filteredThemes.contains($0) }
        }
    }
}

struct ThemeRow: View {
    var theme: ItemTheme
    @State var items: [Item]
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if theme != ItemTheme.allCases.first {
                Divider()
                    .background(.black5)
            }
            
            HStack(alignment: .center, spacing: 0) {
                Button {
                    if items.first(where: { !$0.isPacked }) == nil {
                        for index in items.indices {
                            items[index].isPacked = false
                        }
                    } else {
                        for index in items.indices {
                            items[index].isPacked = true
                        }
                    }
                } label: {
                    Image(systemName: items.first(where: { !$0.isPacked }) == nil ? "a.circle.fill" : "circle")
                        .foregroundStyle(items.first(where: { !$0.isPacked }) == nil ? .black6 : .black5)
                        .font(.title3)
                        .padding(10)
                }
                .padding(.leading, 8)
                
                Text(theme.rawValue)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black7)
                
                Spacer()
                
                // 선택한 아이템 개수 표시
                Text( items.first(where: { !$0.isPacked }) == nil ? "전체선택됨" : "\(selectedItemCount())/\(items.count)")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(.black5)
                
                // 토글 버튼
                Button(action: {
                    isExpanded.toggle()
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
                    .background(.black5)
                
                ForEach($items) { $item in
                    ItemRow(item: $item)
                        .padding(.leading, 30)
                    
                    if let lastItem = items.last {
                        if lastItem.id != item.id {
                            Divider()
                                .background(.black5)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    func selectedItemCount() -> Int {
        items.filter { $0.isPacked }.count
    }
}

struct ItemRow: View {
    @Binding var item: Item
    
    var body: some View {
        HStack(spacing: 0) {
            // 선택 버튼
            Button(action: {
                item.isPacked.toggle()
            }) {
                Image(systemName: item.isPacked ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(item.isPacked ? .black6 : .black5)
                    .font(.title3)
                    .padding(10)
            }
            
            Text(item.name)
                .font(.callout)
                .fontWeight(.regular)
                .foregroundStyle(.black7)
            
            Spacer()
            
            // 숨김 버튼
            Button(action: {
                item.isHidden.toggle()
            }) {
                Image(systemName: item.isHidden ? "eye.slash.fill" : "eye")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(item.isHidden ? .black4 : .black3)
                    .padding(.vertical, 10)
            }
            .padding(.trailing, 16)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
//    AddItemSheet(items: .constant([]), isSheetDisplaying: .constant(true), roomColor: .indigo)
    MyItemView()
}
