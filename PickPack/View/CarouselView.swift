//
//  CarouselView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/21/24.
//

import SwiftUI
struct CarouselView: View {
    // TODO: 티켓 데이터 배열 넘기면 알아서 만들어지도록
    typealias PageIndex = Int
    let pageCount: Int
    let spacing: CGFloat = 45
    
    @GestureState var dragOffset: CGFloat = 0
    
    @State var currentIndex: Int = 0
    
    init(
        pageCount: Int
    ) {
        self.pageCount = pageCount
    }
    
    var body: some View {
        GeometryReader { proxy in
            let visibleEdgeSpace: CGFloat = proxy.size.width - 40
            let baseOffset: CGFloat = spacing + visibleEdgeSpace
            let pageWidth: CGFloat = proxy.size.width - (visibleEdgeSpace + spacing) * 2
            let offsetX: CGFloat = baseOffset + CGFloat(currentIndex) * -pageWidth + CGFloat(currentIndex) * -spacing + dragOffset
            
            HStack(spacing: spacing) {
                ForEach(0..<pageCount, id: \.self) { pageIndex in
                    TicketView()
                        .frame(
                            width: pageWidth,
                            height: proxy.size.height
                        )
                }
                .contentShape(Rectangle())
                
                // TODO: + 버튼 뷰 추가
            }
            .offset(x: offsetX)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, out, _ in
                        out = value.translation.width
                    }
                    .onEnded { value in
                        let offsetX = value.translation.width
                        let progress = -offsetX / pageWidth
                        let increment = Int(progress.rounded())
                        currentIndex = max(min(currentIndex + increment, pageCount - 1), 0)
                    }
            )
        }
    }
}




//#Preview {
//    CarouselView()
//}
