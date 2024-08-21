//
//  SharedItemView.swift
//  PickPack
//
//  Created by 추서연 on 8/21/24.
//

import SwiftUI

struct SharedItemView: View {
    // MARK: 방 이름 받아오기
    private let roomName: String = "순두부 여행"
    // MARK: 방 컬러 받아오기
    private let roomColor: Color = .indigo
    
    @State private var offset: CGFloat = 0
    @State private var currentTab: RoomViewTabs = .SharedItem
    
    var body: some View {
        VStack(spacing: 0) {
            segmentedView
            
            
            switch currentTab {
            case .MyItem:
                MyItemView()
            case .FriendItem:
                Spacer()
            case .SharedItem:
                Spacer()
            }
        }
        .navigationTitle(roomName)
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    // TODO: 홈버튼 구현
                } label: {
                    Image(systemName: "house")
                        .font(.title3)
                        .foregroundStyle(.black6)
                        .padding(10)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    // TODO: 설정 버튼 구현
                } label: {
                    Image(systemName: "gearshape")
                        .font(.title3)
                        .foregroundStyle(.black6)
                        .padding(10)
                }
            }
        }
        //        }
    }
}

extension SharedItemView {
    private var segmentedView: some View {
        GeometryReader { proxy in
            ZStack {
                let selectedBarWidth: CGFloat = proxy.size.width / 3
                
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(.black1)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 50)
                            .foregroundStyle(roomColor)
                            .frame(width: selectedBarWidth)
                            .offset(x: offset)
                    }
                
                HStack(spacing: 0) {
                    ForEach(RoomViewTabs.allCases, id: \.self) { tab in
                        // MARK: 버튼이라 blink 애니메이션이 있는데 탭 전환에는 어울리지 않는 것 같음. onTapGesture로 바꿔야할까요?
                        Button {
                            currentTab = tab
                            withAnimation {
                                switch currentTab {
                                case .MyItem:
                                    offset = 0
                                case .FriendItem:
                                    offset = selectedBarWidth
                                case .SharedItem:
                                    offset = selectedBarWidth * 2
                                }
                            }
                        } label: {
                            Text(tab.rawValue)
                                .font(.subheadline)
                                .fontWeight(currentTab == tab ? .semibold : .regular)
                                .frame(width: selectedBarWidth)
                                .foregroundStyle(currentTab == tab ? .white : .black)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(height: 38)
        .padding(.top, 12)
        .padding(.bottom, 9)
        .padding(.horizontal, 30)
        
    }
}

#Preview {
    NavigationStack {
        SharedItemView()
    }
}
