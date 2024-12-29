import SwiftUI

struct VerificationView: View {
    @State private var verificationCode: String = ""
    @State private var timer: Int = 60 // 타이머 1분
    @State private var isResendEnabled: Bool = false
    @State private var message: String = ""
    @State private var verificationSent: Bool = false
    @State private var verificationCodeToCheck: String = "123456" // 초기 인증번호
    @State private var navigateToHome: Bool = false // 홈 화면으로 이동 여부

    private let initialVerificationCode = "123456" // 틀린 인증번호
    private let resendVerificationCode = "234567" // 올바른 인증번호

    var phoneNumber: String // phoneNumber를 받도록 추가

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    TextField("인증번호 입력", text: $verificationCode)
                        .keyboardType(.numberPad)
                        .onChange(of: verificationCode) { newValue in
                            verificationCode = String(newValue.prefix(6)).filter { $0.isNumber }
                        }
                        .underlineTextFieldStyle()
                    
                    Button(action: {
                        if verificationCode == resendVerificationCode {
                            message = "인증에 성공했습니다."
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                navigateToHome = true // 인증 성공 시 이동
                            }
                        } else {
                            message = "인증번호가 틀렸습니다."
                            // 틀린 인증 메시지를 2초 후 사라지게 함
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                self.message = ""
                            }
                        }
                    }) {
                        Text(isResendEnabled ? "재발송" : "인증 확인")
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 120, height: 40)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.blue.opacity(0.7)]), startPoint: .top, endPoint: .bottom)
                            )
                            .cornerRadius(8)
                            .shadow(radius: 5)
                            .animation(.easeInOut, value: isResendEnabled)
                    }
                    .disabled(!isResendEnabled && verificationCode.isEmpty)
                    .onTapGesture {
                        if isResendEnabled {
                            resendVerificationCodeAction()
                        }
                    }
                }

                if !verificationSent {
                    Text("타이머: \(formattedTime)")
                        .font(.callout)
                        .foregroundColor(.gray)
                }

                if !isResendEnabled {
                    Text("인증 번호가 안오시나요?")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .transition(.opacity)
                }

                if verificationSent {
                    Text("인증 번호를 재발송 합니다.")
                        .font(.caption)
                        .foregroundColor(.blue)
                        .transition(.opacity)
                }

                Text(message)
                    .font(.callout)
                    .foregroundColor(message == "인증에 성공했습니다." ? .green : .red)
                    .animation(.easeInOut, value: message)

                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                    EmptyView() // NavigationLink 동작만 처리
                }
            }
            .padding()
            .onAppear {
                startTimer()
            }
        }
    }

    private var formattedTime: String {
        let minutes = timer / 60
        let seconds = timer % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    private func startTimer() {
        timer = 60 // 타이머를 1분으로 설정
        isResendEnabled = false
        verificationSent = false
        verificationCodeToCheck = initialVerificationCode // 초기 인증번호 설정

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            guard self.timer > 0 else {
                timer.invalidate()
                self.isResendEnabled = true // 재발송 가능하게 설정
                return
            }
            self.timer -= 1
        }
    }

    private func resendVerificationCodeAction() {
        // 타이머 초기화 및 재발송 처리
        startTimer()
        verificationSent = true
        verificationCodeToCheck = resendVerificationCode // 재발송된 인증번호 설정

        // "인증번호가 재발송되었습니다." 메시지 표시 후 3초 후 사라짐
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.verificationSent = false
            self.message = "" // 메시지 초기화
            self.isResendEnabled = false // 재발송 버튼 다시 비활성화
        }
    }
}

extension View {
    func underlineTextFieldStyle() -> some View {
        self
            .padding(.bottom, 8)
            .overlay(Rectangle().frame(height: 1).foregroundColor(.gray), alignment: .bottom)
    }
}

struct VerificationView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationView(phoneNumber: "010-1234-5678") // 미리보기에서 phoneNumber 전달
    }
}





