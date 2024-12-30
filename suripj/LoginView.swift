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
    
    @State private var carrierInfoText: String?
    @State private var isVerificationActive = false
    
    let carriers = ["SKT", "LGU+", "KT"]
    @State private var currentMessage = "이름을 입력해주세요."
    
    var body: some View {
        NavigationView {
            VStack {
                // 상단 텍스트 (이름, 생년월일, 전화번호, 통신사, 정보 확인)
                VStack(alignment: .leading) {
                    Text("\(name.isEmpty ? "" : name + "님!") 안녕하세요👋🏻")
                        .font(.title2)
                        .foregroundColor(.black)
                        .transition(.opacity)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(currentMessage)
                        .font(.title3)
                        .foregroundColor(.black)
                        .padding(.top, 5)
                        .transition(.opacity)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading, 10)
                .padding(.top, 20)

                // 이름 입력
                TextField("이름을 입력해주세요", text: $name)
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
                            withAnimation(.easeIn(duration: 0.5)) {
                                currentMessage = "\(newValue)님 태어난 날 알려줄 수 있어요??👉🏻👈🏻"
                                showBirthDateField = true
                            }
                        }
                        resetErrorsForOtherFields(except: "name")
                    }
                    .onSubmit {
                        if nameError == nil {
                            withAnimation(.easeIn(duration: 0.5)) {
                                currentMessage = "\(name)님 생년월일을 입력해주세요."
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

                // 생년월일 입력 필드 (밑줄 디자인으로 변경)
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
                            birthDate = formatBirthDate(newValue) // 포맷팅 적용
                            if birthDate.count == 8 { // 포맷팅 후 8자리인지 확인
                                withAnimation {
                                    currentMessage = "\(name)님 전화번호.. 물어봐도 괜찮아요?🫣"
                                    showPhoneNumberField = true
                                }
                            }
                        }
                        .keyboardType(.numberPad)
                        .textInputAutocapitalization(.none)
                        .disableAutocorrection(true)

                    if let birthDateError = birthDateError {
                        Text(birthDateError)
                            .foregroundColor(.red)
                            .font(.footnote)
                    }
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
                            if phoneNumber.count == 13 {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    carrierInfoText = "\(name)님! 통신사는 어디 쓰세요?"
                                }
                            }
                            resetErrorsForOtherFields(except: "phoneNumber")
                        }
                        .onSubmit {
                            if phoneNumberError == nil {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    carrierInfoText = "\(name)님! 통신사는 어디 쓰세요?"
                                }
                            }
                        }
                }

                if let phoneNumberError = phoneNumberError {
                    Text(phoneNumberError)
                        .foregroundColor(.red)
                        .font(.footnote)
                }

                // 통신사 선택 버튼 (가로 배열로 수정)
                if !phoneNumber.isEmpty && phoneNumber.count == 13 {
                    VStack {
                        // "통신사는 어디 쓰세요?" 문구 (중앙 정렬)
                        if carrierInfoText != nil {
                            Text(carrierInfoText ?? "")
                                .font(.title3)
                                .foregroundColor(.black)
                                .transition(.opacity)
                                .frame(maxWidth: .infinity, alignment: .center) // 중앙 정렬
                        }
                        
                        HStack {
                            ForEach(carriers, id: \.self) { carrier in
                                Button(action: {
                                    selectedCarrier = carrier
                                    withAnimation(.easeIn(duration: 0.5)) {
                                        carrierInfoText = "\(name)님! 정보가 맞으세요?"
                                    }
                                }) {
                                    HStack {
                                        Image(systemName: selectedCarrier == carrier ? "checkmark.circle.fill" : "circle")
                                        Text(carrier)
                                            .padding()
                                    }
                                    .padding(.horizontal, 10)
                                    .background(selectedCarrier == carrier ? Color.blue : Color.gray)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                }
                            }
                        }
                        
                        // 중앙에 위치한 정보 확인 문구
                        if selectedCarrier != nil {
                            NavigationLink(
                                destination: VerificationView(phoneNumber: phoneNumber),
                                isActive: $isVerificationActive
                            ) {
                                EmptyView()
                            }

                            Button(action: {
                                if isValidPhoneNumber(phoneNumber) {
                                    isVerificationActive = true
                                } else {
                                    phoneNumberError = "올바른 전화번호를 입력해주세요."
                                }
                            }) {
                                Text("확인")
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                                    .padding(.top, 20)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(10)
                }
            }
            .padding()
        }
    }

    private func resetErrorsForOtherFields(except field: String) {
        if field != "name" { nameError = nil }
        if field != "birthDate" { birthDateError = nil }
        if field != "phoneNumber" { phoneNumberError = nil }
    }

    private func resetFieldsForInvalidName() {
        birthDate = ""
        phoneNumber = ""
        selectedCarrier = nil
        showBirthDateField = false
        showPhoneNumberField = false
    }

    private func resetFieldsForInvalidBirthDate() {
        phoneNumber = ""
        selectedCarrier = nil
        showPhoneNumberField = false
    }

    private func formatBirthDate(_ date: String) -> String {
        var formattedDate = date.filter { $0.isNumber }
        if formattedDate.count == 6 {
            formattedDate.insert(".", at: formattedDate.index(formattedDate.startIndex, offsetBy: 2))
            formattedDate.insert(".", at: formattedDate.index(formattedDate.startIndex, offsetBy: 5))
        }
        return formattedDate
    }

    private func formatPhoneNumber(_ number: String) -> String {
        var formatted = number.filter { $0.isNumber }
        if formatted.count > 3 { formatted.insert("-", at: formatted.index(formatted.startIndex, offsetBy: 3)) }
        if formatted.count > 7 { formatted.insert("-", at: formatted.index(formatted.startIndex, offsetBy: 8)) }
        return formatted
    }

    private func isValidName(_ name: String) -> Bool {
        return name.range(of: "^[가-힣]+$", options: .regularExpression) != nil
    }

    private func isValidBirthDate(_ date: String) -> Bool {
        return date.count == 8
    }

    private func isValidPhoneNumber(_ number: String) -> Bool {
        return number.count == 13
    }
}


































































































































































































