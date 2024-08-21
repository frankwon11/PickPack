//
//  ReadyRoomView.swift
//  PickPack
//
//  Created by 추서연 on 8/22/24.
//

import SwiftUI

struct ReadyRoomView: View {
    @EnvironmentObject var router: RouterManager
    
    var body: some View {
        
        VStack(alignment: .center) {
            HStack{
                Text("새 여행 준비하기")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
            }
            .padding(.bottom, 32)
            
            
            
            VStack(alignment:.center){
                
                Button {
                    router.push(view: .createRoomView)
                } label: {
                    RoundedRectangle(cornerRadius: 16)
                        .fill( Color.white )
                        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
                        .overlay(
                            VStack{
                                Text("새로운 여행 만들기")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                                Image(systemName:"rectangle.portrait.badge.plus")
                                    .font(.largeTitle)
                                    .foregroundColor(.black3)
                                    .padding(.vertical,8)
                                Text("새로운 여행 방을 만들고")
                                    .font(.subheadline)
                                    .foregroundColor(.black3)
                                Text("친구들을 초대할 수 있어요")
                                    .font(.subheadline)
                                    .foregroundColor(.black3)
                            }
                        )
                }
                
            }
            .padding(.bottom,10)
            
            VStack(alignment:.center){
                RoundedRectangle(cornerRadius: 16)
                    .fill( Color.white )
                    .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 1)
                    .overlay(
                        VStack{
                            Text("방 초대코드 입력하기")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Image(systemName:"rectangle.portrait.and.arrow.right")
                                .font(.largeTitle)
                                .foregroundColor(.black3)
                                .padding(.vertical,8)
                            Text("친구가 이미 방을 만들었다면")
                                .font(.subheadline)
                                .foregroundColor(.black3)
                            Text("초대코드를 입력하여 방에 참여할 수 있어요")
                                .font(.subheadline)
                                .foregroundColor(.black3)
                        }
                    )
            }
            
            
            
            
        }
        .padding(.horizontal,24)
        .padding(.bottom,200)
        //            .navigationBarBackButtonHidden(true)
        //            .toolbar {
        //                ToolbarItem(placement: .navigationBarLeading) {
        //                    Button(action: {
        //                        dismiss()
        //                    }) {
        //                        HStack {
        //                            Image(systemName: "chevron.left")
        //                                .foregroundColor(.black)
        //                        }
        //                    }
        //                }
        //            }
        ////        Spacer()
        
        
    }
}


#Preview {
    ReadyRoomView()
}

