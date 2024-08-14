//
//  AppleAuthManager.swift
//  PickPack
//
//  Created by LDW on 8/10/24.
//

import Foundation
import AuthenticationServices

// MARK: - AppleLogin 관련 속성 및 메서드 관리
final class AppleAuthManager: ObservableObject {
    @Published var authState = AuthState.signedOut
    
    // 현재 기기에 저장된 유저가 있는지 useridentifier를 이용해서 검사  후 로그인 상태를 반영
    func checkForExistingUser() {
        if let userIdentifier = KeychainHelper.shared.readUserIdentifier() {
            print("User already signed in with userIdentifier: \(userIdentifier)")
            authState = .signedIn
        } else {
            print("No stored userIdentifier, user needs to sign in.")
        }
    }

    // SignInWithAppleButton의 request에 대해 success 응답이 왔을 때 실행
    func handleSuccessfulLogin(with authorization: ASAuthorization) {
        if let userCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = userCredential.user // 아래 예시 중 userIdentifier 사용
            KeychainHelper.shared.saveUserIdentifier(userIdentifier) // 저장
            print(userCredential.user)
            
//            응답으로 받은 계정 정보 종류
//            let UserIdentifier = userCredential.user
//            let fullName = userCredential.fullName
//            let name =  (fullName?.familyName ?? "") + (fullName?.givenName ?? "")
//            let email = userCredential.email
//            let IdentityToken = String(data: userCredential.identityToken!, encoding: .utf8)
//            let AuthorizationCode = String(data: userCredential.authorizationCode!, encoding: .utf8)
            
            // 정보 출력
            if userCredential.authorizedScopes.contains(.fullName) {
                print(userCredential.fullName?.givenName ?? "No given name")
            }
            
            if userCredential.authorizedScopes.contains(.email) {
                print(userCredential.email ?? "No email")
            }
        }
    }
    
    // SignInWithAppleButton의 request에 대해 fail 응답이 왔을 때 실행
    func handleLoginError(with error: Error) {
        print("Could not authenticate: \\(error.localizedDescription)")
    }
}

enum AuthState {
    case signedIn
    case signedOut
}
