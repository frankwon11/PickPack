//
//  FriendItemListView.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendItemListView: View {
    
    @State private var itemList: ItemList = ItemList()
//    @State private var shared: [Item]
//    
//    init(itemList: ItemList) {
//        self.itemList = itemList
//        self.shared = itemList.items.filter({ $0.isShared })
//    }
//    
    var body: some View {
        ScrollView {
            NavigationStack {
                VStack {
                    
                    sharedListView
                    personalListView
                    
                }
                .onAppear {
                    itemList.items[0].isShared.toggle()
                    itemList.items[1].isShared.toggle()
                    itemList.items[2].isShared.toggle()
                }
            }
            .navigationTitle("슌의 짐 리스트")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

extension FriendItemListView {
    @ViewBuilder
    private var sharedListView: some View {
        let shared = itemList.items.indices.filter { itemList.items[$0].isShared }
        VStack{
            Text("공유 짐 리스트")
            
            ForEach(shared, id: \.self) { index in
                    FriendItemRowView(item: $itemList.items[index])
            }
            
        }
    }
    
    @ViewBuilder
    private var personalListView: some View {
        let personal = itemList.items.indices.filter { !itemList.items[$0].isShared }
        VStack {
            Text("개인 짐 리스트")
            
            ForEach(personal, id: \.self) { index in
                    FriendItemRowView(item: $itemList.items[index])
            }
        }
    }
    
}

#Preview {
    FriendItemListView()
}
