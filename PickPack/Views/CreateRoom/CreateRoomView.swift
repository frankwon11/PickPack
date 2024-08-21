//
//  CreateRoomView.swift
//  PickPack
//
//  Created by 추서연 on 8/21/24.
//


import SwiftUI
import Combine

struct CreateRoomView: View {
    @State private var text = ""
    private let characterLimit = 7
    
    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Text("새 여행 만들기")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.horizontal,15)
                        .padding(.bottom,15)
                    Spacer()
                }
                
                RoomNameField()
                    .padding(.vertical,15)
                
                DestinationView()
                    .padding(.vertical,15)
                
                DurationField()
                    .padding(.vertical,15)
                
                RoomColorField()
                    .padding(.vertical,15)
                Spacer()
                    
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        // TODO: - 다음 화면 연결
                    } label: {
                        Text("완료")
                            .bold()
                    }
                }
            }
    }
}

#Preview {
    CreateRoomView()
}
