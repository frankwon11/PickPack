//
//  RoomSettingView.swift
//  PickPack
//
//  Created by 추서연 on 8/21/24.
//

import SwiftUI
import Combine

struct RoomSettingView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var text = ""
    private let characterLimit = 7
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black1
                    .edgesIgnoringSafeArea(.all)
                
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
            .navigationBarTitle("방 설정", displayMode: .inline)
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
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RoomSettingView()
}
