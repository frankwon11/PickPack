//
//  AppleLoginView.swift
//  PickPack
//
//  Created by LDW on 8/10/24.
//
import SwiftUI
import AuthenticationServices

struct AppleLoginView: View {
    var body: some View {
        VStack{
            AppleSigninButton()
        }
        .frame(height:UIScreen.main.bounds.height)
        .background(Color.white)
    }
    
    private struct AppleSigninButton: View {
        @EnvironmentObject var authManager: AppleAuthManager
        
        var body: some View{
            SignInWithAppleButton(
                // 이름과 이메일로 인증 요청
                onRequest: { request in
                    request.requestedScopes = [.fullName, .email]
                },
                onCompletion: { result in
                    // 요청 결과 처리
                    switch result {
                    case .success(let authResults):
                        print("Apple Login Successful")
                        authManager.handleSuccessfulLogin(with: authResults)
                        authManager.authState = .signedIn
                    case .failure(let error):
                        authManager.handleLoginError(with: error)
                        print(error.localizedDescription)
                        print("error")
                    }
                }
            )
            .frame(width : UIScreen.main.bounds.width * 0.9, height:50)
            .cornerRadius(5)
        }
    }
}

