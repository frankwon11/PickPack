//
//  TicketView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/26/24.
//

import SwiftUI

struct TicketView: View {
    // TODO: 티켓 데이터로 한번에 묶일 예정
    let place = "강원도 강릉시"
    let title = "순두부 여행"
    let startDate = "2025.02.12 (월)"
    let endDate = "2025.02.15 (목)"
    
    let user = "슌"
    let members = ["헤이즐", "세이디", "앤드류"]
    
    let invitationCode = "00342F"
    
    let ticketWidth: CGFloat
    
    // TODO: 정수로 표시
    @State var progress: Int = 15
    @State var travelColor: Color = .blue
    
    // 진척도에 따른 가변 width
    var progressBarcodeWidth: CGFloat {
        // 좌우 패딩: -40
        return ((ticketWidth - 40.0) * CGFloat(progress) / 100.0)
    }
    
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
                // MARK: - 여행 장소, 여행 제목
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
                        .padding(.bottom, 20)
                }
                Divider()
                    .foregroundColor(.black)
                    .frame(height: 0.6)
                
                // MARK: - 여행 날짜
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
                .frame(height: 44)
                
                Divider()
                    .foregroundColor(.black)
                    .frame(height: 0.6)
                
                // MARK: - 여행 멤버
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
                .frame(height: 44)
                
                Divider()
                    .foregroundColor(.black)
                    .frame(height: 0.6)
                
                // MARK: - 초대 코드 및 짐 퍼센티지
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
                // MARK: - 진척도 바코드
                ZStack(alignment: .leading) {
                    // TODO: 색상 변경
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .frame(height: 60)
                    Rectangle()
                        .fill(travelColor)
                        .frame(height: 60)
                        .frame(width: progressBarcodeWidth)
                    
                    // 바코드처럼 보이는 직사각형들
                    HStack(spacing: 0) {
                        let barWidthAndSpacing: [(CGFloat, CGFloat)] = {
                            var result: [(CGFloat, CGFloat)] = []
                            var currentWidth: CGFloat = 0
                            while currentWidth < ticketWidth - 40 {
                                let barWidth = CGFloat(Int.random(in: 1...3))
                                let barSpacing = CGFloat(Int.random(in: 1...2))
                                if currentWidth + barWidth + barSpacing > ticketWidth - 40 {
                                    break
                                }
                                result.append((barWidth, barSpacing))
                                currentWidth += barWidth + barSpacing
                            }
                            return result
                        }()
                        
                        ForEach(0..<barWidthAndSpacing.count, id: \.self) { index in
                            Rectangle()
                                .fill(index % 2 == 0 ? .white : .clear)
                                .frame(width: barWidthAndSpacing[index].0, height: 60)
                                .padding(.leading, barWidthAndSpacing[index].1)
                        }
                    }

                }
            } // VStack
            .padding(.horizontal, 22)
            .frame(height: 430)
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
    }
}

#Preview {
    TicketView(ticketWidth: 264)
}
