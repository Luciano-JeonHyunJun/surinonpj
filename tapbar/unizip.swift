import SwiftUI

struct UniZipView: View {
    var body: some View {
        VStack {
            Text("대학 Zip 페이지")
                .font(.largeTitle)
                .foregroundColor(.blue)
            
            // 대학 목록이나 다른 콘텐츠 추가
            List {
                Text("서울대학교")
                Text("연세대학교")
                Text("고려대학교")
                // 추가 대학 목록
            }
        }
        .navigationBarTitle("대학 Zip", displayMode: .inline)
    }
}

struct UniZipView_Previews: PreviewProvider {
    static var previews: some View {
        UniZipView()
    }
}

