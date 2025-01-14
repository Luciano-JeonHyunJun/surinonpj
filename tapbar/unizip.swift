import SwiftUI

struct UniZipView: View {
    @State private var showFilterSheet = false
    @State private var filterMathEssay = false
    @State private var filterHumanitiesEssay = false
    @State private var filterMedicalEssay = false
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        showFilterSheet = true
                    }) {
                        Text("필터")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
                
                ScrollView {
                    VStack(spacing: 10) {
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true) {
                            universityRow("아주대학교", logoName: "!ajou_logo", destination: AjouUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true,hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true){
                            universityRow("중앙대학교", logoName: "!chungang_logo", destination: ChungangUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true){
                            universityRow("이화여자대학교", logoName: "!ewhawoen's_logo", destination: EwhaFMUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true){
                            universityRow("인하대학교", logoName: "!inha_logo", destination: InhaUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true){
                            universityRow("고려대학교 세종캠퍼스", logoName: "!koreaC_logo", destination: KoreaSJUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true){
                            universityRow("경희대학교", logoName:"!kyunghee_logo", destination: KyungheeUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true){
                            universityRow("경북대학교", logoName: "!kyungpook_logo", destination: KyungpookUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true){
                            universityRow("부산대학교", logoName: "!pusan_logo", destination: PusanUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true){
                            universityRow("숙명여자대학교", logoName: "!sookmyungwomen's_logo", destination: SookmyungFMUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true){
                            universityRow("성균관대학교", logoName: "!sungkyunkwan_logo", destination: SungkyunkwanUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true){
                            universityRow("연세대학교 미래캠퍼스", logoName: "!yonseiC_logo", destination: YonseiMRUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("한국항공대학교", logoName: "aerospace_logo", destination: AerospaceUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("가톨릭대학교", logoName: "catholic_logo", destination: CatholicUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("단국대학교", logoName: "dankook_logo", destination: DankookUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("단국대학교 죽전캠퍼스", logoName: "dankookC_logo", destination: DankookCSUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("동덕 여자 대학교", logoName: "dongduk_logo", destination: DonggukUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("동국대학교", logoName: "dongguk_logo", destination: DonggukUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("덕성 여자 대학교", logoName: "duksung_logo", destination: DuksungFMUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("을지대학교", logoName: "eulji_logo", destination: EuljiUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("한국 외국어 대학교", logoName: "foreign_logo", destination: ForeignUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("가천대학교", logoName: "gachon_logo", destination: GachonUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("한신대학교", logoName: "hanshin_logo", destination: HanshinUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("한양대학교", logoName: "hanyang_logo", destination: HanyangUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("홍익대학교", logoName: "hongik_logo", destination: HongikUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("홍익대학교 세종캠퍼스", logoName: "hongikC_logo", destination: HongikSJUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("강남대학교", logoName: "kangnam_logo", destination: KangnamUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("건국대학교", logoName: "konkuk_logo", destination: KonkukUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("국민대학교", logoName: "kookmin_logo", destination: KookminUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("고려대학교", logoName: "korea_logo", destination: KoreaUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("광운대학교", logoName: "kwangwoon_logo", destination: KwangwoonUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("경기대학교", logoName: "kyonggi_logo", destination: KyonggiUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("삼육대학교", logoName: "sahmyook _logo", destination: SahmyookUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("삼명대학교", logoName: "sangmyung _logo", destination: SangmyungUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("세종대학교", logoName: "sejong_logo", destination: SejongUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("서경대학교", logoName: "seokyeong_logo", destination: SeokyeongUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("서울 여자 대학교", logoName: "seoulFM_logo", destination: SeoulFMUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("신한대학교", logoName: "shinhan_logo", destination: ShinhanUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("서울 시립대학교", logoName: "sirip_logo", destination: SiripUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("서강대학교", logoName: "sogang_logo", destination: SogangUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("숭실대학교", logoName: "soongsil_logo", destination: SoongsillUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("서울 과학 기술 대학교", logoName: "sst_logo", destination: SstUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("성신 여자 대학교", logoName: "sungshinFM_logo", destination: SungshinFMUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("수원대학교", logoName: "suwon_logo", destination: SuwonUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("한국기술교육대학교", logoName: "techteach_logo", destination: TeckteachUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("연세대학교", logoName: "yonsei_logo", destination: YonseiUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                    }
                    .padding()
                }
                .background(Color.white)
                .sheet(isPresented: $showFilterSheet) {
                    FilterView(filterMathEssay: $filterMathEssay, filterHumanitiesEssay: $filterHumanitiesEssay, filterMedicalEssay: $filterMedicalEssay)
                }
                .navigationBarHidden(true)
            }
        }
    }
    
    private func shouldShowUniversity(hasMathEssay: Bool, hasHumanitiesEssay: Bool, hasMedicalEssay: Bool) -> Bool {
        if !filterMathEssay && !filterHumanitiesEssay && !filterMedicalEssay {
            return true
        }
        return (filterMathEssay == hasMathEssay || !filterMathEssay)
        && (filterHumanitiesEssay == hasHumanitiesEssay || !filterHumanitiesEssay)
        && (filterMedicalEssay == hasMedicalEssay || !filterMedicalEssay)
    }
    
    private func universityRow(_ name: String, logoName: String, destination: some View, hasMathEssay: Bool, hasHumanitiesEssay: Bool, hasMedicalEssay: Bool) -> some View {
        NavigationLink(destination: destination) {
            HStack {
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

                    HStack {
                        if hasMathEssay {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 10, height: 10)
                            Text("수리논술")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        if hasHumanitiesEssay {
                            Circle()
                                .fill(Color.green)
                                .frame(width: 10, height: 10)
                            Text("인문논술")
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }
                        if hasMedicalEssay {
                            Circle()
                                .fill(Color.purple)
                                .frame(width: 10, height: 10)
                            Text("메디컬")
                                .font(.footnote)
                                .foregroundColor(.gray)
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
        }
    }
}

struct FilterView: View {
    @Binding var filterMathEssay: Bool
    @Binding var filterHumanitiesEssay: Bool
    @Binding var filterMedicalEssay: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("논술 유형")
                .font(.headline)
                .padding(.bottom, 10)
            
            HStack {
                Toggle("수리논술", isOn: $filterMathEssay)
                    .toggleStyle(CheckboxToggleStyle())
                    .padding(.trailing)
                Toggle("인문논술", isOn: $filterHumanitiesEssay)
                    .toggleStyle(CheckboxToggleStyle())
                    .padding(.trailing)
                Toggle("메디컬", isOn: $filterMedicalEssay)
                    .toggleStyle(CheckboxToggleStyle())
            }
            .padding(.bottom, 20)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("적용")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle("필터", displayMode: .inline)
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

struct UniZipView_Previews: PreviewProvider {
    static var previews: some View {
        UniZipView()
    }
}




