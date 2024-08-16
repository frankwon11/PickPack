//
//  FriendItemListView.swift
//  PickPack
//
//  Created by LDW on 8/17/24.
//

import SwiftUI

struct FriendItemListView: View {
    var body: some View {
        ScrollView {
            NavigationStack {
                VStack {
                    Text("Hello, World!")
                }
            }
            .navigationTitle("슌의 짐 리스트")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    FriendItemListView()
}
