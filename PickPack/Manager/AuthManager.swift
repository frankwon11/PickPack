//
//  AuthManager.swift
//  PickPack
//
//  Created by sseungwonnn on 7/8/24.
//

import AuthenticationServices
import FirebaseAuth
import FirebaseCore

enum AuthState {
//    case authenticated // 인증은 받았지만 로그인은 하지 않은 익명 상태
    case signedIn
    case signedOut
}

@MainActor
class AuthManager: ObservableObject {
    @Published var user: User?
    @Published var authState = AuthState.signedOut
    
    private var authStateHandle: AuthStateDidChangeListenerHandle!

    init() {
        configureAuthStateChanges()
    }
    
    
    /// Auth 연결을 활성화합니다.
    private func configureAuthStateChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { auth, user in
            print("인증 변경 여부: \(user != nil)")
            self.updateState(user: user)
        }
    }
    
    /// Auth 연결을 해지합니다.
    private func removeAuthStateListener() {
        Auth.auth().removeStateDidChangeListener(authStateHandle)
    }
    
    /// 사용자 상태를 update 합니다.
    private func updateState(user: User?) {
        self.user = user
        let isAuthenticatedUser = user != nil

        if isAuthenticatedUser {
            self.authState = .signedIn
        } else {
            self.authState = .signedOut
        }
    }
    
    /// 입력 정보를 바탕으로 새로운 사용자를 생성합니다.(회원 가입)
    func authCreateUser(email: String, userName: String, password: String) -> Void? {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
                
                return
            }
            
            if result != nil {
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = userName
                print("사용자 이메일: \(String(describing: result?.user.email))")
            }
        } // Closure
    }
    
    /// 로그인
    func authSignIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("error: \(error.localizedDescription)")
                
                return
            }
            
            if result != nil {
                self.authState = .signedIn
                print("사용자 이메일: \(String(describing: result?.user.email))")
                print("사용자 이름: \(String(describing: result?.user.displayName))")
            }
        }
    }
}
