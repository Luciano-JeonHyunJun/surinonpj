import SwiftUI

// 대학교 세부 정보 페이지
struct KangnamUniversityView: View {
    var body: some View {
        VStack {
            // 대학교 정보 (예시)
            Text("강남대학교")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 대학교의 세부 정보 (예시)
            Text("설립 연도: ")
            Text("위치: ")
            Text("학과: ")
            
            Spacer()
        }
        .navigationBarTitle("강남대학교", displayMode: .inline)
    }
}

struct KangnamUniversityView_Previews: PreviewProvider {
    static var previews: some View {
        KangnamUniversityView()
    }
}
