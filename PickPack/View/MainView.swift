//
//  MainView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/14/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authManager: AuthManager
    
    let tickets: [TicketView] = [TicketView(), TicketView()]
    var body: some View {
        VStack {
            headerView
            
            navigationRow

            Spacer().frame(height: 66)
        
//            CarouselView(pageCount: 2)
//            TicketView()
            EmptyTicketView()
            
            Spacer()
            
            Button {
                Task {
                       do {
                           try await authManager.authSignOut()
                       }
                       catch {
                           print("Error: \(error)")
                       }
                   }
            } label: {
                Text("로그아웃")
            }
        } // VStack
        .padding(.horizontal, 20)

    }
}

extension MainView {
    // MARK: - 상단 뷰
    @ViewBuilder
    private var headerView: some View {
        HStack(alignment: .center) {
            // TODO: 프로필 클릭하면 프로필 설정으로 이동; 네비게이션 링크로 변경
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 46, height: 46)
                .padding([.top, .leading, .trailing], 10)
                .foregroundColor(.white)
                .background(.blue)
                .clipShape(
                    Circle()
                )
            
            Text("\(authManager.user?.displayName)")
                .font(.headline)
                .fontWeight(.medium)
                .foregroundColor(.black)
            
            Spacer()
            
            Button {
                // TODO: 여행 추가 페이지로 이동; 네비게이션 링크로 변경
            } label: {
                Image(systemName: "plus.square.dashed")
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
            }
            
            Button {
                // TODO: 알림 페이지로 이동; 네비게이션 링크로 변경
            } label: {
                Image(systemName: "bell")
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
            }
        }
    }
    
    // MARK: - 중단 네비게이션 뷰
    private var navigationRow: some View {
        HStack {
            HStack {
                Spacer()
                Button {
                    // TODO: 지난 여행 페이지로 이동; 네비게이션 링크로 변경
                } label: {
                    HStack {
                        Image(systemName: "clock")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                        
                        Text("지난 여행")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            }
            
            Rectangle()
                .frame(width: 1)
                .padding(.vertical, 10)
            
            
            HStack {
                Spacer()
                Button {
                    // TODO: 기본 짐 설정 페이지로 이동; 네비게이션 링크로 변경
                } label: {
                    HStack {
                        Image(systemName: "scroll")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                        
                        Text("기본 짐 설정")
                            .font(.subheadline)
                            .fontWeight(.regular)
                            .foregroundColor(.black)
                    }
                }
                Spacer()
            }
                
        }
        .frame(height: 50)
    }
}

#Preview {
    MainView()
}
