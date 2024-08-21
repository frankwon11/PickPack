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
            VStack {
                
                if !member.itemList.filter({ $0.isShared }).isEmpty {
                    FriendSharedList(member: $member)
                }
                
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
            .navigationTitle("\(member.user.name)님의 짐 리스트")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                        .padding(.leading, 15)
                }
            }
        }
        .background(.black1)
    }
}

extension FriendItemListView {
    // TODO: 이거 라우터로 다시 ?
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
