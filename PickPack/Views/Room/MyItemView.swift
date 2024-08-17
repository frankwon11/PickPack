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

    var body: some View {
        VStack(spacing: 0) {
            addItemButton
            
            Spacer()
        }
        .sheet(isPresented: $showAddItemSheet) {
            AddItemSheet(isSheetDisplaying: $showAddItemSheet, ticketColor: roomColor)
        }
        .background(.black1)
    }
}

extension MyItemView {
    private var addItemButton: some View {
        Button {
            showAddItemSheet = true
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(.white)
                
                Label("새로운 짐 추가하기", systemImage: "plus")
                    .font(.subheadline)
                // MARK: 방 색깔
                    .foregroundStyle(.indigo)
            }
        }
        .frame(height: 48)
        .padding(.horizontal, 20)
        .padding(.top, 12)
    }
}

#Preview {
    NavigationStack {
        RoomView()
    }
}
