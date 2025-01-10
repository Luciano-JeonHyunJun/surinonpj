// 메디컬
import SwiftUI

// 대학교 세부 정보 페이지
struct EwhaFMUniversityView: View {
    var body: some View {
        VStack {
            // 대학교 정보 (예시)
            Text("이화여자대학교")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 대학교의 세부 정보 (예시)
            Text("설립 연도: ")
            Text("위치: ")
            Text("학과: ")
            
            Spacer()
        }
        .navigationBarTitle("이화여자대학교", displayMode: .inline)
    }
}

struct EwhaFMUniversityView_Previews: PreviewProvider {
    static var previews: some View {
        EwhaFMUniversityView()
    }
}

