import SwiftUI

// 광운대학교 세부 정보 페이지
struct KwangwoonUniversityView: View {
    var body: some View {
        VStack {
            // 광운대학교 정보 (예시)
            Text("광운대학교")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 광운대학교의 세부 정보 (예시)
            Text("설립 연도: 1885년")
            Text("위치: 서울특별시 서대문구")
            Text("학과: 의과대학, 공과대학, 인문대학 등")
            
            Spacer()
        }
        .navigationBarTitle("광운대학교", displayMode: .inline)
    }
}

struct KwangwoonUniversityView_Previews: PreviewProvider {
    static var previews: some View {
        KwangwoonUniversityView()
    }
}
