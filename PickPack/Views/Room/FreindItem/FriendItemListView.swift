//
//  FriendItemListView.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendItemListView: View {
    
    //@Binding
    @Binding var itemList: ItemList
    let name: String
    @State private var isSharedListOpend: Bool = false
    @State private var color: Color = .pink
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            NavigationStack {
                VStack {
                    
                    FriendSharedList(itemList: $itemList, name: name, color: color)
                    
                    VStack {
                        let themesWithItems = ItemTheme.allCases.filter { theme in
                            !itemList.items.filter { $0.theme == theme }.isEmpty
                        }
                        
                        ForEach(themesWithItems.indices, id: \.self) { index in
                            let theme = themesWithItems[index]
//                            let list = itemList.items.filter { $0.theme == theme }
                            
                            FriendItemList(itemList: $itemList, itemTheme: theme, color: color, isLastRow: index == themesWithItems.indices.last)
                        }
                    }
                    .padding(.vertical, 8)
                    .background(.white)
                    .cornerRadius(8)
                    .padding([.horizontal, .top])
                }
                .padding(.vertical, 16)
                .background(.black1)
               
                .onAppear {
                    itemList.items[0].isShared.toggle()
                    itemList.items[1].isShared.toggle()
                    itemList.items[1].isPacked.toggle()
                    itemList.items[2].isShared.toggle()
                    itemList.items[3].isPacked.toggle()
                    itemList.items[4].isPacked.toggle()
                }
            }
            .navigationTitle("\(name)의 짐 리스트")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        }
        .background(.black1)
    }
}

extension FriendItemListView {
    
    private var backButton : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .aspectRatio(contentMode: .fit)
                    .foregroundStyle(.black)
            }
        }
    }
}
#Preview {
    FriendItemListView(itemList: .constant(ItemList()), name: "슌")
}
