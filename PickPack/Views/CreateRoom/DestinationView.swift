//
//  DestinationView.swift
//  PickPack
//
//  Created by 추서연 on 8/21/24.
//


import SwiftUI
import Combine

struct DestinationView: View {
    @State private var text = ""
    private let characterLimit = 12
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("여행지")
                .font(.callout)
                .padding(.horizontal, 30)
                .foregroundColor(.indigo)
            
            ZStack(alignment: .trailing) {
                TextField("텍스트를 입력하세요", text: $text)
                    .onReceive(Just(text)) { newValue in
                        if newValue.count > characterLimit {
                            text = String(newValue.prefix(characterLimit))
                        }
                    }
                    .padding()
                    .frame(height: 44)
                
                Text("\(text.count)/\(characterLimit)")
                    .padding(.trailing, 15)
                    .foregroundColor(.gray)
                
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 0)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.gray.opacity(0.2)))
                    .frame(height: 44)
            }
            .padding(.horizontal, 15)
        }
    }
}

#Preview {
    DestinationView()
}
