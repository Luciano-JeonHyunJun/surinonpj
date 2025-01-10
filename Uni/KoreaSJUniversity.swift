//메디컬

import SwiftUI

// 대학교 세부 정보 페이지
struct KoreaSJUniversityView: View {
    var body: some View {
        VStack {
            // 대학교 정보 (예시)
            Text("고려대학교 세종캠퍼스")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 대학교의 세부 정보 (예시)
            Text("설립 연도: ")
            Text("위치: ")
            Text("학과: ")
            
            Spacer()
        }
        .navigationBarTitle("고려대학교 세종캠퍼스", displayMode: .inline)
    }
}

struct KoreaSJUniversityView_Previews: PreviewProvider {
    static var previews: some View {
        KoreaSJUniversityView()
    }
}
