//
//  CarouselView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/21/24.
//

import SwiftUI

//struct CarouselView: View {
//    // TODO: 티켓 데이터 배열 넘기면 알아서 만들어지도록
//    typealias TicketIndex = Int
//    let ticketCount: Int = 5
//    let trailingSpace: CGFloat = 64
//    let spacing: CGFloat = 44
//    
//    
//    @GestureState var dragOffset: CGFloat = 0
//    
//    @State var currentIndex: Int = 0
//    
//    var body: some View {
//        GeometryReader { proxy in
//            /// Setting correct Width for snap Carousel...
//            let width = proxy.size.width - (trailingSpace - spacing)
//            let adjustMentWidth = (trailingSpace / 2) - spacing
//            
//            HStack(spacing: spacing) {
//                ForEach(0..<ticketCount, id: \.self) { ticketIndex in
//                    TicketView()
//                        .frame(width: proxy.size.width - trailingSpace * 2, height: 430)
//                        .border(.red)
//                }
//                .contentShape(Rectangle())
//                
////                EmptyTicketView()
////                    .contentShape(Rectangle())
////                    .frame(width: width, height: 430)
//            }
//            .border(.blue)
//            /// Spacing will be horizontal padding
//            .padding(.horizontal, trailingSpace)
//            /// setting only after 0th index..
//            .offset(x: (CGFloat(currentIndex) * -width)
//                    + (currentIndex != 0 ? adjustMentWidth : 0)
//                    + dragOffset)
//            .gesture(
//                DragGesture()
//                    .updating($dragOffset, body: { value, out, _ in
//                        out = value.translation.width
//                    })
//                    .onEnded({ value in
//                        /// Updating Current Index..
//                        let offsetX = value.translation.width
//                        
//                        /// were going to convert the transation into progress (0 - 1)
//                        /// and round the value...
//                        /// based on the progress increasing or decreasing the currentIndex...
//                        let progress = -offsetX / width
//                        
//                        let roundIndex = Int(progress.rounded())
//                        
//                        currentIndex = max(min(currentIndex + roundIndex, ticketCount - 1), 0)
//                    })
//            )
//        }
//        // Animatiing when dragOffset is 0
//        .animation(.easeInOut, value: dragOffset == 0)
//    }
//}


struct CarouselView: View {
    @GestureState var dragOffset: CGFloat = 0
    
    @State var currentIndex: Int = 0
    
    /// pageCount는 1 이상입니다.
    let pageCount: Int = 1
    let spacing: CGFloat = 44
    let visibleEdgeSpace: CGFloat = 20
    
    
    var body: some View {
        GeometryReader { proxy in
            
            /// 첫번째 요소의 왼쪽 여백입니다.
            let baseOffset: CGFloat = spacing + visibleEdgeSpace
            
            /// 티켓 하나 width를 나타냅니다.
            let pageWidth: CGFloat = proxy.size.width - (visibleEdgeSpace + spacing) * 2
            
            /// HStack에서 보여질 곳을 정합니다.
            let offsetX: CGFloat = baseOffset + CGFloat(currentIndex) * -pageWidth + CGFloat(currentIndex) * -spacing + dragOffset

            HStack(spacing: spacing) {
                ForEach(0..<pageCount - 1, id: \.self) { pageIndex in
                    TicketView()
                        .frame(width: pageWidth)
                }
                .contentShape(RoundedRectangle(cornerRadius: 20))
                
                EmptyTicketView()
                    .frame(width: pageWidth)
                    .contentShape(RoundedRectangle(cornerRadius: 20))
            }
            /// offset을 통해 보이는 곳을 옮깁니다.
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
            /// dragOffset이 0이 되면 다음 페이지로 넘어갑니다.
            .animation(.easeInOut, value: dragOffset == 0)
        }
    }
}

#Preview {
    CarouselView()
}
