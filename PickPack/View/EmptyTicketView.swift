//
//  EmptyTicketView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/26/24.
//

import SwiftUI

struct EmptyTicketView: View {
    var body: some View {
        ZStack {
            // TODO: 색상 변경
            RoundedRectangle(cornerRadius: 20)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
                .foregroundColor(.black3)
            
            // TODO: 색상 변경
            VStack(alignment: .center, spacing: 12) {
                Image(systemName: "plus")
                    .font(.system(size: 34))
                    .foregroundColor(.black5)
                
                Text("여기를 눌러서\n새 여행을 준비해보세요!")
                    .font(.title3)
                    .fontWeight(.regular)
                    .foregroundColor(.black5)
                    .frame(alignment: .center)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(height: 430)   
    }
}

#Preview {
    EmptyTicketView()
}
