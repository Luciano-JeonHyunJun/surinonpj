import SwiftUI

struct unisearchpage: View {
    @State private var searchText: String = "" // 검색 텍스트
    @State private var filteredUniversities: [String] = [] // 필터링된 대학 리스트
    
    // 샘플 대학 리스트
    let allUniversities = [
        "서울대학교", "남서울대학교", "청주대학교", "청주교육대학교", "연세대학교", "고려대학교", "서울과학기술대학교", "서울시립대학교"
    ]
    
    // 검색어에 맞춰 대학 필터링
    func filterUniversities() {
        if searchText.isEmpty {
            filteredUniversities = []
        } else {
            filteredUniversities = allUniversities.filter { $0.contains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            TextField("대학교를 검색해보세요", text: $searchText, onCommit: {
                filterUniversities() // 검색어가 입력될 때마다 필터링
            })
            .padding(10)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(8)
            .padding()

            // 검색어에 맞는 대학이 있을 때
            if !filteredUniversities.isEmpty {
                List(filteredUniversities, id: \.self) { university in
                    VStack(alignment: .leading) {
                        Text(university)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.blue)
                            .onTapGesture {
                                // 대학을 클릭하면 별도의 세부 페이지로 이동하는 로직을 추가하거나 팝업을 띄우는 방식으로 구현 가능
                                print("\(university) 선택됨")
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
            } else {
                // 검색된 대학이 없을 때 표시할 메시지
                Text("검색된 대학이 없습니다.")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .regular))
                    .padding()
            }
        }
        .navigationTitle("대학교 검색")
        .onChange(of: searchText) { _ in
            filterUniversities() // 검색어가 바뀔 때마다 필터링
        }
    }
}

struct UniversityDetailView: View {
    var universityName: String
    
    var body: some View {
        Text("\(universityName) 세부 페이지")
            .font(.title)
            .foregroundColor(.blue)
            .navigationBarTitle(universityName, displayMode: .inline)
    }
}


