//
//  SignInView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/14/24.
//

import SwiftUI

struct SignInView: View {
    @EnvironmentObject var authManager: AuthManager
    
    @State var emailInput: String = ""
    @State var passwordInput: String = ""
    @State var signInProcessing: Bool = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 15) {
                Text("이메일로 로그인하세요")
                    .font(.largeTitle)
                    .lineSpacing(10)
                
                    VStack {
                        TextField("이메일을 입력하세요", text: $emailInput)
                            .padding()
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .textInputAutocapitalization(.never)
                        SecureField("비밀번호를 입력하세요", text: $passwordInput)
                            .padding()
                            .background(.thinMaterial)
                            .cornerRadius(10)
                            .padding(.bottom, 30)
                    }
                    
                    // 로그인 접속중에 signInProcessing = false 이거나 유저 정보가 비어있다면
                    if signInProcessing {
                        ProgressView()
                    }
                
                
                Button {
                    signInProcessing = true
                    authManager.authSignIn(email: emailInput, password: passwordInput)
                    
                    
                } label: {
                    Text("로그인")
                        .padding()
                        .foregroundColor(.white)
                        .background(emailInput.isEmpty || passwordInput.isEmpty == true ? .gray : .red)
                        .cornerRadius(10)
                        .padding(.bottom, 40)
                }
                .disabled(emailInput.isEmpty || passwordInput.isEmpty ? true : false)
                // 회원가입 View로 이동
                HStack {
                    Text("아이디가 없으십니까?")
                    
                    NavigationLink {
                        SignUpView()
                    } label: {
                        HStack {
                            Text("지금 만드세요.")
                            Image(systemName: "arrow.up.forward")
                            
                        }
                    }
                }
                
            }
            .padding()
        }
    }
}

#Preview {
    SignInView()
}
