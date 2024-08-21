//
//  CustomItemAddView.swift
//  PickPack
//
//  Created by Lee Sihyeong on 8/22/24.
//

import SwiftUI

struct CustomItemAddView: View {
    @Binding var itemList: ItemList
    @Environment(\.dismiss) private var dismiss
    @State private var text: String = ""
    @State private var theme: ItemTheme?
    @FocusState var isFocused: Bool
    
    let roomColor: Color
    
    var body: some View {
        ZStack {
            Color.black1
            
            VStack(spacing: 0) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.white)
                    
                    TextField("사용자정의 짐", text: $text)
                        .focused($isFocused)
                        .padding(.horizontal, 16)
                        .onChange(of: text) {
                            if text.count > 10 {
                                text = String(text.prefix(10))
                            }
                        }
                    if !text.isEmpty {
                        HStack {
                            Spacer()
                            Text("\(text.count)/10")
                                .foregroundStyle(.black4)
                            Button {
                                text = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .padding(.trailing, 10)
                                    .foregroundStyle(.black4)
                            }
                            .padding(.trailing, 10)
                        }
                    }
                }
                .frame(height: 48)
                .padding(.top, 20)
                .padding(.bottom, 16)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundStyle(.white)
                    
                    HStack {
                        Text("대분류")
                        
                        Spacer()
                        
                        Picker("", selection: $theme) {
                            Text("선택")
                            
                            Divider()
                            
                            ForEach(ItemTheme.allCases, id: \.self) { theme in
                                Text(theme.rawValue)
                                    .tag(theme as ItemTheme?)
                            }
                        }
                        .tint(theme == nil ? .black4 : .black)
                    }
                    .padding(.leading, 16)
                }
                .frame(height: 48)
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("사용자정의 짐 추가하기")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .background(.black1)
        .onAppear {
            isFocused = true
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Text("취소")
                        .foregroundStyle(.black)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                if text.isEmpty || theme == nil {
                    Text("완료")
                        .foregroundStyle(.black4)
                } else {
                    Button {
//                        itemList.items.append(Item(id: UUID().uuidString, name: text, theme: theme))
                        dismiss()
                    } label: {
                        Text("완료")
                            .foregroundStyle(roomColor)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CustomItemAddView(itemList: .constant(.init()), roomColor: .indigo)
    }
}
