//
//  RoomSettingView.swift
//  PickPack
//
//  Created by 추서연 on 8/22/24.
//

import SwiftUI
import Combine

struct RoomSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var router: RouterManager
    @State private var text = ""
    
    private let characterLimit = 7
    var body: some View {
        ZStack {
            Color.black1
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(alignment: .leading) {
                    Divider()
                        .foregroundColor(.black3)
                    
                    SettingRoomNameField()
                        .padding(.vertical,15)
                    
                    SettingDestinationView()
                        .padding(.vertical,15)
                    
                    SettingDurationField()
                        .padding(.vertical,15)
                    
                    SettingRoomColorField()
                        .padding(.vertical,15)
                    
                    Spacer()
                    
                }
            }
            
            
        }
        .navigationBarTitle("방 설정", displayMode: .inline)
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
    RoomSettingView()
}
