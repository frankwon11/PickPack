//
//  SettingDestinationView.swift
//  PickPack
//
//  Created by 추서연 on 8/22/24.
//

import SwiftUI
import Combine

struct SettingDestinationView: View {
    @State private var text = ""
    private let characterLimit = 12
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("여행지")
                .font(.callout)
                .padding(.horizontal, 30)
                .foregroundColor(.black)
            
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isTextFieldFocused ? Color.black : Color.clear , lineWidth: 0.5)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill( Color.white )
                    )
                    .frame(height: 44)
                
                TextField("텍스트를 입력하세요", text: $text)
                    .onReceive(Just(text)) { newValue in
                        if newValue.count > characterLimit {
                            text = String(newValue.prefix(characterLimit))
                        }
                    }
                    .padding(.horizontal)
                    .frame(height: 44)
                    .focused($isTextFieldFocused)
                    .background(Color.clear)
                    .padding(5)
                
                
                Text("\(text.count)/\(characterLimit)")
                    .padding(.trailing, 15)
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 15)
        }
    }
}

#Preview {
    SettingDestinationView()
}
