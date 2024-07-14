//
//  SignUpView.swift
//  PickPack
//
//  Created by sseungwonnn on 7/14/24.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authManager: AuthManager
    
    @State private var nameInput: String = ""
    @State private var emailInput: String = ""
    @State private var passwordInput: String = ""
    @State private var confirmPasswordInput: String = ""
    
    @State var isShowingProgressView = false // 로그인 비동기 ProgressView
    @State var isShowingAlert: Bool = false // 로그인 완료 Alert
    
    @State var isPasswordLengthError: Bool = false // 비밀번호 6자리 이상 확인
    @State var isPasswordMatchError: Bool = false // 비밀번호 텍스트 일치 확인
    
    @State var isEmailError: Bool = false // 이메일 에러
    @State var emailErrorText: String = "" // 이메일 에러 Text
    
    @Environment(\.dismiss) private var dismiss
    
    var canSignUp: Bool {
        if nameInput.isEmpty || emailInput.isEmpty || passwordInput.isEmpty || confirmPasswordInput.isEmpty {
            return false
        }
        return true
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                VStack {
                    Text("이메일 ID 생성")
                        .font(.largeTitle)
                    
                    Text("하나의 ID로 모든 서비스를 이용할 수 있습니다.")
                }
                .lineSpacing(10)
                
                VStack(alignment: .leading) {
                    Text("이름")
                        .font(.headline)
                    TextField("이름을 입력해주세요", text: $nameInput)
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                }
                
                VStack(alignment: .leading) {
                    Text("이메일")
                        .font(.headline)
                    TextField("이메일을 입력해주세요", text: $emailInput)
                        .keyboardType(.emailAddress) // e-mail 형식 사용
                        .autocapitalization(.none)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding()
                        .background(.thinMaterial)
                        .cornerRadius(10)
                        .textInputAutocapitalization(.never)
                }
                
                VStack(alignment: .leading) {
                    Text("비밀번호")
                         .font(.headline)
                    SecureField("비밀번호를 6자리 이상 입력해주세요", text: $passwordInput)
                         .padding()
                         .background(.thinMaterial)
                         .cornerRadius(10)
                    Text("비밀번호는 6자리 이상 입력해주세요.")
                         .font(.system(size: 15))
                         .foregroundColor(isPasswordLengthError ? .red : .clear)
                }
                
                VStack(alignment: .leading) {
                    Text("비밀번호 확인")
                    SecureField("비밀번호를 다시 입력해주세요", text: $confirmPasswordInput)
                        .padding()
                        .background(.thinMaterial)
                        .border(.red, width: confirmPasswordInput != passwordInput ? 1 : 0)
                        .cornerRadius(10)
                    Text("비밀번호가 서로 다릅니다.")
                        .font(.system(size: 15))
                        .foregroundColor(isPasswordMatchError ? .red : .clear)
                    }
                
                Button {
                    isShowingProgressView = true // ProgressView 보이기
                    
                    if passwordInput.count < 6 {
                        isPasswordLengthError = true
                    }
                    if confirmPasswordInput != passwordInput {
                        isPasswordMatchError = true
                    }
                    if passwordInput.count >= 6 && confirmPasswordInput == passwordInput {
                       authManager.authCreateUser(email: emailInput, userName: nameInput, password: passwordInput)
                        isShowingAlert = true
                    }
                } label: {
                    Text("회원 가입")
                        .frame(width: 100, height: 50)
                        .background(!canSignUp ? .gray : .blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .alert("회원가입", isPresented: $isShowingAlert) {
                            Button {
                                dismiss()
                            } label: {
                                Text("OK")
                            }
                        } message: {
                            Text("회원가입이 완료되었습니다.")
                        }
                        .padding()
                }
                .disabled(!canSignUp)
                
                //(2)
                if isShowingProgressView {
                    ProgressView()
                }

            }
            .padding()
            .padding(.bottom, 15)
            
        }

    }
}

#Preview {
    SignUpView()
}
