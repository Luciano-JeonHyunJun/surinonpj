import SwiftUI

// 고려대학교 세부 정보 페이지
struct KoreaUniversityView: View {
    var body: some View {
        VStack {
            // 고려대학교 정보 (예시)
            Text("고려대학교")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 고려대학교의 세부 정보 (예시)
            Text("설립 연도: 1905년")
            Text("위치: 서울특별시 성북구")
            Text("학과: 의과대학, 공과대학, 인문대학 등")
            
            Spacer()
        }
        .navigationBarTitle("고려대학교", displayMode: .inline)
    }
}

struct KoreaUniversityView_Previews: PreviewProvider {
    static var previews: some View {
        KoreaUniversityView()
    }
}

