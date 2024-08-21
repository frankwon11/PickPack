//
//  RoomView.swift
//  PickPack
//
//  Created by Lee Sihyeong on 8/16/24.
//

import SwiftUI

struct RoomView: View {
    @EnvironmentObject var router: RouterManager
    
    // MARK: 방 이름 받아오기
    private let roomName: String = "순두부 여행"
    // MARK: 방 컬러 받아오기
    private let roomColor: Color = .indigo
    
    @State private var offset: CGFloat = 0
    @State private var currentTab: RoomViewTabs = .MyItem
    
    var body: some View {
        VStack(spacing: 0) {
            segmentedView
            
            // TODO: 탭뷰를 커스텀한 느낌으로 뷰 하나 만들어질 때마다 Spacer()에 뷰 넣기
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
                    router.backToMain()
                } label: {
                    Image(systemName: "house")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black6)
                        .padding(10)
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    router.push(view: .settingView)
                } label: {
                    Image(systemName: "gearshape")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                        .foregroundStyle(.black6)
                        .padding(10)
                }
            }
        }
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
        RoomView()
    }
}
