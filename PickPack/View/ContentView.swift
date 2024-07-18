//
//  ContentView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/5/24.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var authManager: AuthManager
    
    var body: some View {
        NavigationStack {
            VStack {
                if authManager.authState == .signedIn {
                    MainView()
                } else {
                    SignInView()
                }
            }
            .onAppear {
                if Auth.auth().currentUser != nil {
                    authManager.authState = .signedIn
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
