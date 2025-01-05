import SwiftUI

struct snuinfo: View { // 이름을 UniversityInfoView로 변경
    var universityName: String
    
    // 서울대학교 정보 (예시)
    let universityInfo = [
        "서울대학교": [
            "설립 연도": "1946년",
            "위치": "서울특별시 관악구",
            "학과": "의과대학, 공과대학, 인문대학, 사회과학대학, 자연과학대학 등"
        ]
    ]
    
    var body: some View {
        VStack {
            // 로고 이미지
            Image("snu_logo") // "snu_logo"는 로고 이미지 이름 (Asset에 추가된 이름)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200) // 로고 크기 조정
                .padding()
            
            // 대학 이름
            Text(universityName)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            // 기본 정보
            if let info = universityInfo[universityName] {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(info.keys.sorted(), id: \.self) { key in
                        Text("\(key): \(info[key]!)")
                            .font(.body)
                            .padding(.bottom, 5)
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .navigationBarTitle(universityName, displayMode: .inline)
    }
}


