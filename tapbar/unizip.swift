import SwiftUI

struct UniZipView: View {
    var body: some View {
        // NavigationView로 네비게이션 기능을 활성화합니다.
        NavigationView {
            List {
                // 연세대학교와 고려대학교 항목을 리스트로 표시하고, 클릭 시 각 대학교의 세부 정보 페이지로 네비게이션합니다.
                universityRow("연세대학교", logoName: "yonsei_logo", destination: YonseiUniversityView(), hasMathEssay: false, hasHumanitiesEssay: true, hasmedicalEssay: false)
                universityRow("고려대학교", logoName: "korea_logo", destination: KoreaUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasmedicalEssay: true)
                universityRow("한양대학교", logoName: "hanyang_logo", destination: HanyangUniversityView(), hasMathEssay: true, hasHumanitiesEssay: false, hasmedicalEssay: false)
                
        
            }
            .listStyle(PlainListStyle()) // List 스타일을 평범하게 설정
            .navigationBarHidden(true) // 네비게이션 바 숨기기
            .background(Color.white) // 배경색을 하얀색으로 설정
        }
    }
    
    // universityRow 함수는 각 대학교 항목을 나타내며, 클릭 시 해당 대학교에 대한 상세 정보 페이지로 이동할 수 있도록 합니다.
    private func universityRow(_ name: String, logoName: String, destination: some View, hasMathEssay: Bool, hasHumanitiesEssay: Bool, hasmedicalEssay: Bool) -> some View {
        HStack {
            // 대학교 로고 표시
            Image(logoName)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .padding(.trailing, 10)

            VStack(alignment: .leading) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)

                // 수리논술과 인문논술 동그라미 표시
                HStack {
                    // 수리논술이 있는 경우
                    if hasMathEssay {
                        Circle()
                            .fill(Color.blue) // 파란색 동그라미
                            .frame(width: 10, height: 10)
                        Text("수리논술")
                            .font(.footnote)
                            .foregroundColor(.gray) // 회색으로 글자 색상
                    }
                    
                    // 인문논술이 있는 경우
                    if hasHumanitiesEssay {
                        Circle()
                            .fill(Color.green) // 초록색 동그라미
                            .frame(width: 10, height: 10)
                        Text("인문논술")
                            .font(.footnote)
                            .foregroundColor(.gray) // 연두색으로 글자 색상
                    
                        if hasmedicalEssay {
                            Circle()
                                .fill(Color.purple) //보라색 동그라미
                                .frame(width: 10, height: 10)
                            Text("메디컬")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .background(
            NavigationLink(destination: destination) {
                EmptyView()
            }
        )
    }
}

struct UniZipView_Previews: PreviewProvider {
    static var previews: some View {
        UniZipView()
    }
}












