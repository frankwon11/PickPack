//
//  HistoryView.swift
//  PickPack
//
//  Created by sseungwonnn on 8/21/24.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        ZStack {
            Color(.black1).ignoresSafeArea()
            ScrollView {
                VStack {
                    HStack {
                        Text("지난 여행")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(.black7)
                        
                        Spacer()
                    }
                    Spacer().frame(height: 16)
                    
                    VStack(spacing: 14){
                        HistoryRow()
                        HistoryRow()
                        HistoryRow()
                        HistoryRow()
                        HistoryRow()
                        HistoryRow()
                        HistoryRow()
                    }
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

struct HistoryRow: View {
    // TODO: Travel 객체 받아오기
    let name: String = "순두부여행"
    let place = "강원도 강릉시"

    let startDate = Date.now
    let endDate = Date.now
    
    let user = "슌"
    let members = ["헤이즐", "세이디", "앤드류"]
    
    let invitationCode = "00342F"

    
    // TODO: 정수로 표시
    @State var progress: Int = 15
    @State var travelColor: Color = .blue
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(name)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(travelColor)
            
            Spacer().frame(height: 16)
            
            Text("\(place)")
                .font(.headline)
                .fontWeight(.regular)
                .foregroundStyle(.black6)
            
            
            HStack {
                Text("\(startDate.dateString) ~ \(endDate.dateString)")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundStyle(.black6)
                
                Spacer()
                
                Text("\(startDate.getDuration(to: endDate))")
                    .font(.subheadline)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        Rectangle()
                            .fill(travelColor)
                    )
            }
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 20)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.white)
        )
    }
}
#Preview {
    HistoryView()
}
