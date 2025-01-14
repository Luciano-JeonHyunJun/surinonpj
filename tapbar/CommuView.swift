import SwiftUI

struct CommuView: View {
    // 대학 목록 (6개 채널)
    let universities = [
        "고려대 논술", "연세대 논술", "서울대 논술", "한양대 논술", "이화여대 논술", "중앙대 논술"
    ]
    
    // 선택된 대학
    @State private var selectedUniversity: String?

    var body: some View {
        NavigationView {
            VStack {
                // 채널 형식의 스와이프 가능한 리스트
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(universities, id: \.self) { university in
                            VStack {
                                ZStack {
                                    // 채널 카드
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.blue)
                                        .frame(width: 200, height: 120)
                                        .shadow(radius: 5)
                                    
                                    Text(university)
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                }
                                .onTapGesture {
                                    // 대학을 선택했을 때 해당 대학 이름을 selectedUniversity에 저장
                                    selectedUniversity = university
                                }
                                
                                // 선택된 대학에 대한 정보 표시
                                if selectedUniversity == university {
                                    Text("\(university)에 대한 세부 정보입니다.")
                                        .font(.body)
                                        .padding()
                                        .foregroundColor(.black)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 180)
                
                Spacer()
            }
            .navigationTitle("대학 논술 채널")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

