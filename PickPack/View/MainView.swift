//
//  MainView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/14/24.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
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

    }
}

#Preview {
    MainView()
}
