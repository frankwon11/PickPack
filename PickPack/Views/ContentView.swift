//
//  ContentView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/5/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AppleAuthManager
    
    var body: some View {
        NavigationStack {
//            // 로그인 분기 처리
//            VStack {
//                if authManager.authState == .signedIn {
//                    MainView()
//                } else {
//                    AppleLoginView()
//                }
//            }
//            .onAppear {
//                authManager.checkForExistingUser()
//            }
            
            // 테스트를 위해서 MainView 수정
            // 로그인 분기 처리
            VStack {
                Text("세이디 파이팅")
            }
        }
        
    }
}

#Preview {
    ContentView()
}
