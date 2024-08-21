//
//  FAQView.swift
//  PickPack
//
//  Created by 추서연 on 8/22/24.
//

import SwiftUI
struct FAQView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        //NavigationStack {
            ZStack {
                Color.black1
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .center) {
                    Text("000@gmail.com")
                    
                    Text("버그가 있어도 그런가보다 너른 양해와 이해 부탁")
                        .foregroundColor(.black)
                        .padding(20)
                    
                    Text("🙏🏻 🙏🏻 🙏🏻 문의는 디엠 주세요 🙏🏻 🙏🏻 🙏🏻")
                        .foregroundColor(.black)
                }
                
                
            }
            .navigationBarTitle("문의", displayMode: .inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        }
                    }
                }
            }
    }
}

#Preview {
    FAQView()
}
