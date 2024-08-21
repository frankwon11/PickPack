//
//  FirebaseLoginTest.swift
//  PickPack
//
//  Created by LDW on 8/21/24.
//

import SwiftUI
import FirebaseAuth

struct FirebaseLoginTest: View {
    @EnvironmentObject var authManager: AppleAuthManager
    
    var body: some View {
        VStack {
            if authManager.authState == .signedIn {
                Text("Login success")
  
                Button {
                    KeychainHelper.shared.deleteUserIdentifier()
                    authManager.authState = .signedOut
                } label: {
                    Text("로그아웃")
                }
                
            } else {
                AppleLoginView()
            }
        }
        .onAppear {
            authManager.checkForExistingUser()
        }
    }
}

#Preview {
    FirebaseLoginTest()
}
