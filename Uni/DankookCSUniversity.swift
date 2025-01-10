//천안캠퍼스
import SwiftUI

// 대학교 세부 정보 페이지
struct DankookCSUniversityView: View {
    var body: some View {
        VStack {
            // 대학교 정보 (예시)
            Text("단국대학교 천안캠퍼스")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            // 대학교의 세부 정보 (예시)
            Text("설립 연도: ")
            Text("위치: ")
            Text("학과: ")
            
            Spacer()
        }
        .navigationBarTitle("단국대학교 천안캠퍼스", displayMode: .inline)
    }
}

struct DankookCSUniversityView_Previews: PreviewProvider {
    static var previews: some View {
        DankookCSUniversityView()
    }
}
