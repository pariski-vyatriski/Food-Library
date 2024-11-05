import SwiftUI

struct CalculatorCalories: View {
    private enum Field: Int, CaseIterable {
        case textInputAge, textInputHeight, textInputWeight
    }
///enter and choose the information
    @State private var selectedGender: SideOfTypeGender = .maleGender
    @State private var textInputActivity = ""
    @State private var textInputAge = ""
    @State private var textInputHeight = ""
    @State private var textInputWeight = ""
    @State private var selectedActivity = Activity.minimal
    @State private var veightMaintence: Float! = 0
    ///other
    @State private var isTextVisible: Bool = false
    @FocusState private var focusedField: Field!


    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(spacing: 6) {
                            VStack {
                                Image(.image3)
                                    .resizable()
                                    .scaledToFit() // Сохраняет пропорции изображения
                                    .frame(maxWidth: .infinity, maxHeight:150) // Устанавливает максимальную ширину и высоту
                                    .clipped()
                            }
                            VStack(alignment: .leading, spacing: 15) {
                                VStack {
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        Text("Gender")
                                            .font(.custom("SFPro-Bold", size: 18))
                                        Picker("Choose", selection: $selectedGender) {
                                            ForEach(SideOfTypeGender.allCases, id: \.self) { gender in
                                                Text(gender.rawValue).tag(gender)
                                            }
                                        }
                                        .frame(maxWidth: .infinity)
                                        .background(.second)
                                        .cornerRadius(9)
                                        .pickerStyle(SegmentedPickerStyle())
                                    }
                                    VStack(alignment: .leading) {
                                        Text("Activity")
                                            .font(.custom("SFPro-Bold", size: 18))
                                        Picker("Animal", selection: $selectedActivity) {
                                            ForEach(Activity.allCases) { activity in
                                                Text(activity.rawValue)
                                            }
                                        }.pickerListStyle()
                                    }
                                    VStack {
                                        VStack(alignment: .leading) {
                                            Text("Age")
                                                .font(.custom("SFPro-Bold", size: 18))
                                            TextField("Select your age", text: $textInputAge)
                                                .focused($focusedField, equals: .textInputAge)
                                                .keyboardType(.numberPad)
                                                .textFieldModifier()
                                        }
                                        VStack(alignment: .leading) {
                                            Text("Height")
                                            TextField("Tape your height", text: $textInputHeight)
                                                .focused($focusedField, equals: .textInputHeight)
                                                .keyboardType(.decimalPad)
                                                .textFieldModifier()
                                        }
                                        VStack(alignment: .leading) {
                                            Text("Weight") // Corrected spelling
                                                .font(.custom("SFPro-Bold", size: 18))
                                            TextField("Tape your weight", text: $textInputWeight) // Corrected spelling
                                                .focused($focusedField, equals: .textInputWeight)
                                                .keyboardType(.decimalPad)
                                                .textFieldModifier()
                                        }
                                    }.toolbar {
                                        ToolbarItem(placement: .keyboard) {
                                            Button("Done") {
                                                focusedField = nil
                                            }
                                        }
                                    }
                                    VStack {
                                        Rectangle()
                                            .frame(width: 361, height: 0)
                                        Button {
                                            isTextVisible.toggle()
                                        } label: {
                                            HStack {
                                                Text("Continue")
                                                    .font(.custom("SFPro-Bold", size: 18))
                                            }.padding(EdgeInsets(top: 15, leading: 140, bottom: 15, trailing: 140))

                                        }.buttonStyle(.myButtonStyle)

                                    }
                                }
                            }
                        }.navigationTitle("Calories")
                            .frame(minHeight: geometry.size.height)
                            .frame(idealWidth: geometry.size.width)
                            .padding(.horizontal, 16)
                    }
                }
                // TODO: correct smth
            }
        }
    }
}

enum SideOfTypeGender: String, CaseIterable, Identifiable {
    var id: Self { self }
    case maleGender = "Male"
    case femaleGender = "Female"
}

enum Activity: String, CaseIterable, Identifiable {
    case minimal = "Minimal"
    case low = "Low"
    case medium = "Medium"
    case high = "High"
    case veryHigh = "Very High"
    var id: Self { self }
}
//
//struct CalculatorCalories_Previews: PreviewProvider {
//    static var previews: some View {
//        CalculatorCalories()
//    }
//}
