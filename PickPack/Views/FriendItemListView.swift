//
//  FriendItemListView.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendItemListView: View {
    
    //@Binding
    @State private var itemList: ItemList = ItemList()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

     var backButton : some View {  // <-- 👀 커스텀 버튼
         Button{
             self.presentationMode.wrappedValue.dismiss()
         } label: {
             HStack {
                 Image(systemName: "chevron.left") // 화살표 Image
                     .aspectRatio(contentMode: .fit)
                     .foregroundStyle(.black)
             }
         }
     }
    
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
                    itemList.items[1].isPacked.toggle()
                    itemList.items[2].isShared.toggle()
                    itemList.items[3].isPacked.toggle()
                    itemList.items[4].isPacked.toggle()
                }
            }
            .navigationTitle("슌의 짐 리스트")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
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
