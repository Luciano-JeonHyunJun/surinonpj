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
                            universityRow("연세대학교", logoName: "yonsei_logo", destination: YonseiUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true) {
                            universityRow("고려대학교", logoName: "korea_logo", destination: KoreaUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false) {
                            universityRow("한양대학교", logoName: "hanyang_logo", destination: HanyangUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true) {
                            universityRow("가톨릭대학교", logoName: "catholic_logo", destination: CatholicUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: true)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false) {
                            universityRow("건국대학교", logoName: "konkuk_logo", destination: KonkukUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("경기대학교", logoName: "kyonggi_logo", destination: KyonggiUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
                        }
                        if shouldShowUniversity(hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false){
                            universityRow("광운대학교", logoName: "kwangwoon_logo", destination: KwangwoonUniversityView(), hasMathEssay: true, hasHumanitiesEssay: true, hasMedicalEssay: false)
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


