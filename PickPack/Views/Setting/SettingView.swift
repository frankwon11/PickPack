//
//  SettingView.swift
//  PickPack
//
//  Created by 추서연 on 8/21/24.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        NavigationView {
            ZStack {
                
                Color.black1
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment:.leading){
                    
                    Text("설정")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    VStack{
                        // TODO: - RoomSettingView 현재 방 이름, 여행지, 기간, 색상 데이터 넘겨주기
                        NavigationLink(destination: RoomSettingView()) {
                            HStack {
                                Text("방 설정")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding(.horizontal, 20)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Divider()
                            .padding(.vertical,6)
                        
                        HStack{
                            Text("방 초대코드")
                            Spacer()
                            HStack {
                                Text("00342F")
                                    .foregroundColor(.blue)
                                
                                Button(action: {
                                    // TODO: - 방코드 넘겨주기
                                    UIPasteboard.general.string = "00342F"
                                }) {
                                    Image(systemName: "doc.on.doc.fill")
                                        .foregroundColor(.black2)
                                }
                            }
                            
                            .padding(.vertical,8)
                            .padding(.horizontal,12)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.black1)
                            )
                            
                        }
                        .padding(.horizontal,20)
                    }
                    .padding(.top,20)
                    .padding(.bottom,10)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    )
                    
                    NavigationLink(destination: FAQView()) {
                        HStack {
                            Text("문의")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                        .padding(20)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white)
                    )
                    
                }
                .padding(.horizontal,20)
                .padding(.bottom,456)
            }
        }
    }
}

#Preview {
    SettingView()
}


