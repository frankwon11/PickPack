//
//  RoomView.swift
//  PickPack
//
//  Created by Lee Sihyeong on 8/16/24.
//

import SwiftUI

struct RoomView: View {
    // MARK: 방 이름 받아오기
    private let roomName: String = "순두부 여행"
    @State private var offset: CGFloat = 0
    @State private var currentTab: RoomViewTabs = .MyItem
    
    var body: some View {
        // 네비게이션 링크로 들어올거니까 네비게이션스택은 주석
        //        NavigationStack {
        VStack {
            segmentedView
            
            // TODO: 탭뷰를 커스텀한 느낌으로 뷰 하나 만들어질 때마다 Spacer()에 뷰 넣기
            switch currentTab {
            case .MyItem:
                Spacer()
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

extension RoomView {
    private var segmentedView: some View {
        GeometryReader { proxy in
            ZStack {
                let selectedBarWidth: CGFloat = proxy.size.width / 3
                
                RoundedRectangle(cornerRadius: 50)
                    .foregroundStyle(.black1)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 50)
                            // MARK: 방 컬러 받아오기
                            .foregroundStyle(.indigo)
                            .frame(width: selectedBarWidth)
                            .offset(x: offset)
                    }
                
                HStack(spacing: 0) {
                    ForEach(RoomViewTabs.allCases, id: \.self) { tab in
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
        .padding(.horizontal, 30)
        
    }
}

#Preview {
    RoomView()
}
