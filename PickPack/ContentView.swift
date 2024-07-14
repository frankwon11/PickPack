//
//  ContentView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/5/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if authManager.authState == .signedIn {
                    mainView()
                } else {
                    SignInView()
                }
            }
            .padding(.horizontal)
        }
        
    }
}

#Preview {
    ContentView()
}
