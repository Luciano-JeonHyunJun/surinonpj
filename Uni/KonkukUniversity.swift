import SwiftUI

// 건국대학교 세부 정보 페이지
struct KonkukUniversityView: View {
    var body: some View {
        VStack {
            // 건국대학교 정보 (예시)
            Text("건국대학교")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 건국대학교의 세부 정보 (예시)
            Text("설립 연도: 1885년")
            Text("위치: 서울특별시 서대문구")
            Text("학과: 의과대학, 공과대학, 인문대학 등")
            
            Spacer()
        }
        .navigationBarTitle("건국대학교", displayMode: .inline)
    }
}

struct KonkukUniversityView_Previews: PreviewProvider {
    static var previews: some View {
        KonkukUniversityView()
    }
}