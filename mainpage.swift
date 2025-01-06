import SwiftUI

struct ContentView: View {
    var body: some View {
        HomeView()
    }
}

struct HomeView: View {
    @State private var selectedTab: String = "홈" // 기본 탭: 홈
    @State private var userName: String = "이용자님" // 사용자 이름
    @State private var targetDate: Date = Calendar.current.date(byAdding: .day, value: 100, to: Date()) ?? Date() // 목표 대학 날짜
    @State private var newsContent = ["논술 준비의 핵심은?", "최신 논술 트렌드 소개", "효과적인 공부 방법", "2024년 수능 논술 대비 전략"] // 뉴스 내용
    @State private var communityPosts = ["Q. 논술 준비 중인 분들과 소통해요!", "A. 서로 질문하고 답변을 남겨보세요.", "Q. 최근 논술에서 어떤 질문이 나왔나요?", "A. 다른 사람들의 팁을 공유해보세요."] // 커뮤니티 대표글
    @State private var columnContent = [
        "합격한 선배 1: 논술 준비의 모든 것",
        "합격한 선배 2: 재수생을 위한 팁",
        "합격한 선배 3: 논술 시험에서의 실수",
        "합격한 선배 4: 논술 시험이란?",
        "합격한 선배 5: 2024 논술 전략"
    ] // 칼럼 미리보기 내용
    @State private var newsIndex = 0 // 뉴스 내용 인덱스
    @State private var communityIndex = 0 // 커뮤니티 대표글 인덱스
    @State private var columnIndex = 0 // 칼럼 인덱스
    @State private var targetDayText = "목표 대학 원서 접수 디데이"
    @State private var targetDayIndex = 0
    let targetDays = [
        "목표 대학 원서 접수 디데이",
        "목표 대학 원서 접수 마감 디데이",
        "논술 날짜 디데이",
        "합격 날짜 디데이"
    ]
    
    let newsRefreshInterval = 5.0 // 뉴스 새로 고침 시간 간격
    let communityRefreshInterval = 5.0 // 커뮤니티 대표글 변경 시간 간격
    @State private var isTappedZip = false // 기출 모음 Zip 클릭 애니메이션 상태
    @State private var isTappedAI = false // AI 첨삭 서비스 클릭 애니메이션 상태
    @State private var isTappedColumnZip = false // 칼럼Zip 클릭 애니메이션 상태
    @State private var searchText = "" // 검색창 입력 텍스트
    @State private var relatedSchools: [String] = [] // 연관 검색어 리스트
    @State private var navigateToSearchPage = false // 검색 후 UniSearchPage로 이동 여부

    // 샘플 대학 리스트
    let allUniversities = [
        "서울대학교", "남서울대학교", "청주대학교", "청주교육대학교", "연세대학교", "고려대학교"
    ]
    
    // 연관 검색어 업데이트
    func updateRelatedSchools() {
        if searchText.isEmpty {
            relatedSchools = []
        } else {
            relatedSchools = allUniversities.filter { $0.contains(searchText) }
        }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 홈 탭
            NavigationView {
                ScrollView {
                    VStack(spacing: 20) {
                        // 상단 영역
                        HStack {
                            // 프로필 사진
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)

                            // 검색창
                            TextField("대학교를 검색해보세요", text: $searchText, onCommit: {
                                navigateToSearchPage = true
                            })
                                .padding(10)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(8)
                                .onChange(of: searchText, perform: { value in
                                    updateRelatedSchools() // 검색어 변경 시 연관 검색어 업데이트
                                })

                            // 디데이
                            Text(targetDayText)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.red)
                                .padding(.leading, 10)
                                .transition(.opacity)
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { _ in
                                        withAnimation(.easeInOut(duration: 1.0)) {
                                            targetDayIndex = (targetDayIndex + 1) % targetDays.count
                                            targetDayText = targetDays[targetDayIndex]
                                        }
                                    }
                                }
                        }
                        .padding(.horizontal)

                        // 사용자 이름 표시
                        Text("\(userName) 오늘도 화이팅 하세요!")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.blue)
                            .padding(.top, 10)

                        // 연관 검색어 표시
                        if !relatedSchools.isEmpty {
                            VStack {
                                ForEach(relatedSchools, id: \.self) { school in
                                    NavigationLink(destination: UniversityDetailView(universityName: school)) {
                                        Text(school)
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(.blue)
                                            .padding()
                                            .transition(.move(edge: .top))
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, minHeight: 160)
                            .background(Color(UIColor.systemGray6))
                            .cornerRadius(10)
                        }

                        // 기출 모음 Zip & AI 첨삭 서비스
                        HStack(spacing: 15) {
                            VStack {
                                Text("기출 모음 Zip")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("학습할 수 있는 논술 기출이 120개!")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.45, height: 120)
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                            .scaleEffect(isTappedZip ? 0.95 : 1)
                            .onTapGesture {
                                withAnimation {
                                    isTappedZip.toggle()
                                    isTappedAI = false
                                }
                            }

                            VStack {
                                Text("AI 첨삭 서비스")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                Text("인공지능으로 빠르고 정확하게!")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .frame(width: UIScreen.main.bounds.width * 0.45, height: 120)
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(10)
                            .scaleEffect(isTappedAI ? 0.95 : 1)
                            .onTapGesture {
                                withAnimation {
                                    isTappedAI.toggle()
                                    isTappedZip = false
                                }
                            }
                        }
                        .padding(.horizontal)

                        // 뉴스와 커뮤니티 탭
                        VStack {
                            HStack {
                                Button(action: {
                                    selectedTab = "뉴스"
                                }) {
                                    Text("뉴스")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(selectedTab == "뉴스" ? .blue : .gray)
                                }
                                .padding(.horizontal)

                                Button(action: {
                                    selectedTab = "커뮤니티"
                                }) {
                                    Text("커뮤니티")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(selectedTab == "커뮤니티" ? .blue : .gray)
                                }
                                .padding(.horizontal)

                                Button(action: {
                                    selectedTab = "칼럼Zip"
                                }) {
                                    Text("칼럼Zip")
                                        .font(.system(size: 18, weight: .medium))
                                        .foregroundColor(selectedTab == "칼럼Zip" ? .blue : .gray)
                                }
                                .padding(.horizontal)
                            }

                            // 선택된 탭의 콘텐츠
                            if selectedTab == "뉴스" {
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(newsContent, id: \.self) { content in
                                        Text(content)
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(.blue)
                                            .padding()
                                            .transition(.move(edge: .top))
                                    }
                                }
                                .frame(maxWidth: .infinity, minHeight: 160)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: newsRefreshInterval, repeats: true) { _ in
                                        withAnimation(.easeInOut(duration: 1.0)) {
                                            newsIndex = (newsIndex + 1) % newsContent.count
                                        }
                                    }
                                }
                            } else if selectedTab == "커뮤니티" {
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(communityPosts, id: \.self) { post in
                                        Text(post)
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(.blue)
                                            .padding()
                                            .transition(.move(edge: .top))
                                    }
                                }
                                .frame(maxWidth: .infinity, minHeight: 160)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                                .onAppear {
                                    Timer.scheduledTimer(withTimeInterval: communityRefreshInterval, repeats: true) { _ in
                                        withAnimation(.easeInOut(duration: 1.0)) {
                                            communityIndex = (communityIndex + 1) % communityPosts.count
                                        }
                                    }
                                }
                            } else if selectedTab == "칼럼Zip" {
                                VStack(alignment: .leading, spacing: 10) {
                                    ForEach(columnContent, id: \.self) { column in
                                        Text(column)
                                            .font(.system(size: 16, weight: .regular))
                                            .foregroundColor(.blue)
                                            .padding()
                                            .transition(.move(edge: .top))
                                    }
                                }
                                .frame(maxWidth: .infinity, minHeight: 160)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.top)
                }
                .navigationBarTitle("홈", displayMode: .inline)
                .navigationBarHidden(true) // 네비게이션 바 숨김
            }
            .tabItem {
                Image(systemName: "house.fill")
                Text("홈")
            }
            .tag("홈")
            
            // 대학Zip 탭
            NavigationView {
                UniZipView()
            }
            .tabItem {
                Image(systemName: "book.fill")
                Text("대학Zip")
            }
            .tag("대학Zip")
            
            // 커뮤니티 탭
            NavigationView {
                CommuView()
            }
            .tabItem {
                Image(systemName: "bubble.right.fill")
                Text("커뮤니티")
            }
            .tag("커뮤니티")
            
            // 전체 탭
            NavigationView {
                AllZipView()
            }
            .tabItem {
                Image(systemName: "square.grid.2x2.fill")
                Text("전체")
            }
            .tag("전체")
        }
    }
}

































