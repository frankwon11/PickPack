//
//  TicketView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/26/24.
//

import SwiftUI

struct TicketView: View {
    let place = "강원도 강릉시"
    let title = "순두부 여행"
    let startDate = "2025.02.12 (월)"
    let endDate = "2025.02.15 (목)"
    
    let user = "슌"
    let members = ["헤이즐", "세이디", "앤드류"]
    
    let invitationCode = "00342F"
    
    @State var progress = 15
    @State var travelColor:Color = .blue
    var body: some View {
        ZStack {
            // 티켓 테두리
            Rectangle()
                .fill(travelColor)
                .frame(height: 430)
               
            // 티켓 배경
            Rectangle()
                .fill(.white)
                .frame(height: 430)
                .padding(.horizontal, 12)
            
            // 티켓 내용
            VStack(spacing: 12) {
                HStack {
                    VStack(alignment: .leading) {
                        Spacer().frame(height: 40)
                        
                        // TODO: 색상 처리
                        Text("\(place)")
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Text("\(title)")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    Spacer()
                        
                    
                    Text("JIMKKONG")
                        .font(.caption2)
                        .fontWeight(.regular)
                        .rotationEffect(.degrees(90))
                        .fixedSize()
                        .frame(width: 13, height: 58)
                }
                Divider()
                    .foregroundColor(.black)
                    .frame(height: 0.6)
                
                HStack(alignment: .center) {
                    VStack(alignment: .center, spacing: 2) {
                        Circle()
                            .fill(.black)
                            .frame(width: 5, height: 5)
                        
                        // TODO: 색상 변경
                        ForEach(0..<3) { _ in
                            Rectangle()
                                .fill(.black)
                                .frame(width: 1, height: 4)
                        }
                        
                        Circle()
                            .fill(.black)
                            .frame(width: 5, height: 5)
                    }
                    
                    // TODO: 색상 변경
                    VStack(spacing: 2) {
                        Text("\(startDate)")
                            .font(.body)
                            .fontWeight(.regular)
                        
                        Text("\(endDate)")
                            .font(.body)
                            .fontWeight(.regular)
                    }
                    Spacer()
                        // TODO: 몇박 며칠 계산 Date Extension 추가
                    Text("3박 4일")
                        .font(.callout)
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .background(
                            Rectangle()
                                .fill(travelColor)
                        )
                        .padding(.top, 22)
                }
                
                Divider()
                    .foregroundColor(.black)
                    .frame(height: 0.6)
                
                HStack(alignment: .center) {
                    ForEach(members, id: \.self) { member in
                        Circle()
                            .fill(.blue)
                            .frame(width: 35.7, height: 35.7)
                            .clipShape(Circle())
                            .background(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 37.8, height: 37.8)
                            )
                            .padding(.leading, -16)
                    }
                    
                    Spacer()
                    Text("\(members.count)명")
                        .font(.callout)
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(.horizontal, 6)
                        .background(
                            Rectangle()
                                .fill(travelColor)
                        )
                        .padding(.top, 19.5)
                }
                .padding(.leading, 20)
                
                Divider()
                    .foregroundColor(.black)
                    .frame(height: 0.6)
                
                HStack {
                    Text("\(invitationCode)")
                        .font(.title)
                        .fontWeight(.regular)
                        .rotationEffect(.degrees(90))
                        .fixedSize()
                        .frame(width: 34, height: 101)
                    Spacer()
                    
                    VStack(alignment: .trailing) {
                        Text("짐 싸기")
                            .font(.footnote)
                            .fontWeight(.regular)
                        
                        Text("\(progress)%")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 42)
                    
                }
                Divider()
                    .foregroundColor(.black)
                    .frame(height: 0.6)
                Spacer()
            } // VStack
            .padding(.horizontal, 22)
            .frame(height: 430)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 44)
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
        
    }
    
    
}

#Preview {
    TicketView()
}
