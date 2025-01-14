import SwiftUI

// 한국항공대학교 세부 정보 페이지
struct AerospaceUniversityView: View {
    var body: some View {
        VStack {
            // 한국항공대학교 정보 (예시)
            Text("한국항공대학교")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 대학교의 세부 정보 (예시)
            Text("설립 연도: ")
            Text("위치: ")
            Text("학과: ")
            
            Spacer()
        }
        .navigationBarTitle("한국항공대학교", displayMode: .inline)
    }
}

struct AerospaceniversityView_Previews: PreviewProvider {
    static var previews: some View {
        AerospaceUniversityView()
    }
}
