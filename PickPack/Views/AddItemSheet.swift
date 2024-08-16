//
//  AddItemSheet.swift
//  PickPack
//
//  Created by sseungwonnn on 8/16/24.
//

import SwiftUI

struct AddItemSheet: View {
    // TODO: 상위 뷰에서 State로 넘겨주고, Binding으로 받아서 사용.
    /*@Binding */var itemList: ItemList = ItemList()
    @Binding var isSheetDisplaying: Bool
    
    var ticketColor: Color
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(filteredThemes(), id: \.self) { theme in
                        ThemeRow(theme: theme, items: itemList.filterItems(by: theme))
                    }
                }
            }
            .searchable(text: $searchText, prompt: "검색할 항목을 입력하세요")
            .navigationTitle("새로운 짐 추가하기")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isSheetDisplaying = false
                    }) {
                        Text("취소")
                            .foregroundStyle(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // TODO: 완료 버튼 동작 추가
                        isSheetDisplaying = false
                    }) {
                        Text("완료")
                            .foregroundStyle(ticketColor)
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
    var items: [Item]
    @State private var isExpanded: Bool = true
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text(theme.rawValue)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black7)
                
                Spacer()
                
                // 선택한 아이템 개수 표시
                Text("\(selectedItemCount())/\(items.count)")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(.black5)
                
                // 토글 버튼
                Button(action: {
                    isExpanded.toggle()
                }) {
                    Image(systemName: isExpanded ? "arrowtriangle.up.fill" : "arrowtriangle.down.fill")
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundStyle(.black5)
                }
            }
            
            if isExpanded {
                ForEach(items) { item in
                    ItemRow(item: item)
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
    @State var item: Item
    
    var body: some View {
        HStack {
            // 선택 버튼
            Button(action: {
                item.isPacked.toggle()
            }) {
                Image(systemName: item.isPacked ? "checkmark.circle.fill" : "circle")
                    .foregroundStyle(item.isPacked ? .black6 : .black5)
            }
            
            Text(item.name)
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(.black7)
            
            Spacer()
            
            // 숨김 버튼
            Button(action: {
                item.isHidden.toggle()
            }) {
                Image(systemName: item.isHidden ? "eye.slash.fill" : "eye.fill")
                    .font(.headline)
                    .fontWeight(.regular)
                    .foregroundColor(item.isHidden ? .black4 : .black3)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    AddItemSheet(isSheetDisplaying: .constant(true), ticketColor: .blue)
}
