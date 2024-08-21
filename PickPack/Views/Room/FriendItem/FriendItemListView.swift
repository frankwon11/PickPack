//
//  FriendItemListView.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendItemListView: View {
    
    // @Binding
    // @Binding var itemList: ItemList
    // let name: String
    @State private var isSharedListOpend: Bool = false
    @Binding var member: Member
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
           // NavigationStack {
                VStack {
                    
                    FriendSharedList(member: $member)
                    
                    VStack {
                        let themesWithItems = ItemTheme.allCases.filter { theme in
                            !member.itemList.filter { $0.theme == theme }.isEmpty
                        }
                        
                        ForEach(themesWithItems.indices, id: \.self) { index in
                            let theme = themesWithItems[index]
                            FriendItemList(itemList: $member.itemList, itemTheme: theme, color: member.color.color, isLastRow: index == themesWithItems.indices.last)
                        }
                    }
                    .padding(.vertical, 8)
                    .background(.white)
                    .cornerRadius(8)
                    .padding([.horizontal, .top])
                }
                .padding(.vertical, 16)
                .background(.black1)
//            }
//            .navigationTitle("\(name)의 짐 리스트")
//            .navigationBarTitleDisplayMode(.large)
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: backButton)
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
    FriendItemList(itemList: .constant(ItemList().items), itemTheme: .clothing, color: .red, isLastRow: false)
}
