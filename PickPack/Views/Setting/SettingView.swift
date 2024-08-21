//
//  SettingView.swift
//  PickPack
//
//  Created by 추서연 on 8/22/24.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var router: RouterManager
    @Environment(\.dismiss) private var dismiss

    
    var body: some View {
        ZStack {
            Color.black1
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment:.leading){
                
                Text("설정")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                VStack{
                    // TODO: - RoomSettingView 현재 방 이름, 여행지, 기간, 색상 데이터 넘겨주기
                    HStack {
                        Text("방 설정")
                        Spacer()
                        Button {
                            router.push(view: .roomSettingView)
                        } label: {
                            Image(systemName: "chevron.right")
                                .font(.title3)
                                .foregroundStyle(.black6)
                                .padding(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 20)
                    
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
                HStack {
                    Text("문의")
                    Spacer()
                    Button {
                        router.push(view: .faqView)
                    } label: {
                        Image(systemName: "chevron.right")
                            .font(.title3)
                            .foregroundStyle(.black6)
                            .padding(10)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white)
                )
                
            }
            .padding(.horizontal,20)
            .padding(.bottom,456)
        }
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
    SettingView()
}


