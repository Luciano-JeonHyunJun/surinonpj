import SwiftUI
import Combine

struct LoginView: View {
    @State private var name = ""
    @State private var birthDate = ""
    @State private var phoneNumber = ""
    @State private var verificationCode = ""
    
    @State private var showBirthDateField = false
    @State private var showPhoneNumberField = false
    @State private var selectedCarrier: String?
    
    @State private var nameError: String?
    @State private var birthDateError: String?
    @State private var phoneNumberError: String?
    
    @State private var isVerificationStarted = false
    @State private var remainingTime = 300 // 5 minutes in seconds
    @State private var verificationSent = false
    @State private var showResendButton = false
    @State private var showErrorMessage = false
    
    @State private var carrierInfoText: String? // 통신사 선택 후 보여줄 텍스트
    
    let carriers = ["SKT", "LGU+", "KT"] // 통신사 버튼 3개
    
    var body: some View {
        VStack {
            // 상단에 "정보를 확인해 주세요" 문구 추가
            if let carrierInfoText = carrierInfoText {
                Text(carrierInfoText)
                    .font(.title2)
                    .bold() // 볼드체로 설정
                    .foregroundColor(.black)
                    .padding(.top, 10) // 이름 위에 위치하도록 상단 여백 조정
                    .padding(.leading, 10) // 왼쪽 여백을 더 좁힘
                    .transition(.slide)
            }
            
            // 이름 입력
            TextField("이름", text: $name)
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color.white)
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(name.isEmpty ? .gray : (nameError != nil ? .red : (isValidName(name) ? .green : .blue)))
                        .padding(.top, 30), alignment: .bottom
                )
                .onChange(of: name) { newValue in
                    if !isValidName(newValue) {
                        nameError = "이름은 한글만 입력할 수 있습니다."
                        resetFieldsForInvalidName()
                    } else {
                        nameError = nil
                    }
                    resetErrorsForOtherFields(except: "name")
                }
                .onSubmit {
                    if nameError == nil {
                        withAnimation(.easeIn(duration: 0.5)) {
                            showBirthDateField = true
                        }
                    }
                }
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            
            if let nameError = nameError {
                Text(nameError)
                    .foregroundColor(.red)
                    .font(.footnote)
            }
            
            // 생년월일 입력
            if showBirthDateField {
                TextField("생년월일 (YYMMDD)", text: $birthDate)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(birthDate.isEmpty ? .gray : (birthDateError != nil ? .red : (isValidBirthDate(birthDate) ? .green : .blue)))
                            .padding(.top, 30), alignment: .bottom
                    )
                    .onChange(of: birthDate) { newValue in
                        // 생년월일 필터링 및 변환
                        birthDate = formatBirthDate(newValue)
                        if !isValidBirthDate(birthDate) {
                            birthDateError = "올바른 생년월일을 입력해주세요."
                            resetFieldsForInvalidBirthDate()
                        } else {
                            birthDateError = nil
                            // 생년월일이 유효하면 전화번호 입력 필드를 표시
                            withAnimation(.easeIn(duration: 0.5)) {
                                showPhoneNumberField = true
                            }
                        }
                        resetErrorsForOtherFields(except: "birthDate")
                    }
                    .onSubmit {
                        if birthDateError == nil {
                            withAnimation(.easeIn(duration: 0.5)) {
                                showPhoneNumberField = true
                            }
                        }
                    }
                    .onReceive(Just(birthDate)) { _ in
                        // 입력값을 숫자 6자만 허용하도록
                        birthDate = birthDate.filter { $0.isNumber }
                        if birthDate.count > 6 {
                            birthDate = String(birthDate.prefix(6)) // 6자만 허용
                        }
                    }
            }
            
            if let birthDateError = birthDateError {
                Text(birthDateError)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            // 전화번호 입력
            if showPhoneNumberField {
                TextField("전화번호 (010-nnnn-nnnn)", text: $phoneNumber)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(phoneNumber.isEmpty ? .gray : (phoneNumberError != nil ? .red : (isValidPhoneNumber(phoneNumber) ? .green : .blue)))
                            .padding(.top, 30), alignment: .bottom
                    )
                    .onChange(of: phoneNumber) { newValue in
                        phoneNumber = formatPhoneNumber(newValue)
                        if !isValidPhoneNumber(phoneNumber) {
                            phoneNumberError = "올바른 전화번호를 입력해주세요."
                        } else {
                            phoneNumberError = nil
                            // 전화번호 입력 완료 시 통신사 버튼 표시
                            withAnimation(.easeIn(duration: 0.5)) {
                                carrierInfoText = nil
                            }
                        }
                        resetErrorsForOtherFields(except: "phoneNumber")
                    }
                    .onSubmit {
                        if phoneNumberError == nil {
                            withAnimation(.easeIn(duration: 0.5)) {
                                carrierInfoText = "정보를 확인해 주세요."
                            }
                        }
                    }
            }
            
            if let phoneNumberError = phoneNumberError {
                Text(phoneNumberError)
                    .foregroundColor(.red)
                    .font(.footnote)
            }

            // 통신사 선택 버튼 (3개의 버튼)
            if !phoneNumber.isEmpty && phoneNumber.count == 13 {
                VStack {
                    HStack {
                        ForEach(carriers, id: \.self) { carrier in
                            Button(action: {
                                selectedCarrier = carrier
                                carrierInfoText = "정보를 확인해 주세요." // 통신사 선택 후 텍스트 변경
                            }) {
                                Text(carrier)
                                    .padding()
                                    .background(selectedCarrier == carrier ? Color.blue : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .padding(.horizontal, 5)
                            }
                        }
                    }
                    
                    if selectedCarrier != nil {
                        Button(action: {
                            // 확인 버튼 동작 추가
                        }) {
                            Text("확인")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                                .padding(.top, 20)
                        }
                    }
                }
                .padding(.top, 20)
            }
        }
        .padding()
    }
    
    private func resetErrorsForOtherFields(except field: String) {
        if field != "name" {
            nameError = nil
        }
        if field != "birthDate" {
            birthDateError = nil
        }
        if field != "phoneNumber" {
            phoneNumberError = nil
        }
    }

    private func resetFieldsForInvalidName() {
        // 이름이 유효하지 않으면 생년월일, 전화번호, 통신사 등 모두 초기화
        birthDate = ""
        phoneNumber = ""
        selectedCarrier = nil
        showBirthDateField = false
        showPhoneNumberField = false
    }

    private func resetFieldsForInvalidBirthDate() {
        // 생년월일이 유효하지 않으면 전화번호, 통신사 등만 초기화
        phoneNumber = ""
        selectedCarrier = nil
        showPhoneNumberField = false
    }
    
    private func formatBirthDate(_ date: String) -> String {
        var formattedDate = date.filter { $0.isNumber }
        
        // 생년월일 형식 변환: YYMMDD -> YY.MM.DD
        if formattedDate.count == 6 {
            formattedDate.insert(".", at: formattedDate.index(formattedDate.startIndex, offsetBy: 2))
            formattedDate.insert(".", at: formattedDate.index(formattedDate.startIndex, offsetBy: 5))
        }

        return formattedDate
    }

    private func formatPhoneNumber(_ number: String) -> String {
        var formatted = number.filter { $0.isNumber }
        if formatted.count > 3 {
            formatted.insert("-", at: formatted.index(formatted.startIndex, offsetBy: 3))
        }
        if formatted.count > 7 {
            formatted.insert("-", at: formatted.index(formatted.startIndex, offsetBy: 8))
        }
        return formatted
    }

    private func isValidName(_ name: String) -> Bool {
        return name.range(of: "^[가-힣]+$", options: .regularExpression) != nil
    }
    
    private func isValidBirthDate(_ date: String) -> Bool {
        return date.count == 8 // YY.MM.DD 형식에서 6자리 숫자가 정확히 들어가야 함
    }
    
    private func isValidPhoneNumber(_ number: String) -> Bool {
        return number.count == 13 // 010-xxxx-xxxx 형태
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}



















































































































































































