import SwiftUI

struct CalculatorCalories: View {
    private enum Field: Int, CaseIterable {
        case textInputAge, textInputHeight, textInputWeight
    }
/// enter and choose the information
    @State private var selectedGender: SideOfTypeGender = .maleGender
    @State private var textInputActivity = ""
    @State private var textInputAge = ""
    @State private var textInputHeight = ""
    @State private var textInputWeight = ""
    @State private var selectedActivity = Activity.minimal
    /// for counting
    @State private var firstResult: Float! = 0
    @State private var secondResult: Int! = 0
    @State private var secondResultSave: Int! = 0
    @State private var secondResultMore: Int! = 0
    @State private var veightMaintence: Float! = 0
    /// other
    @State private var isTextVisible: Bool = false
    @FocusState private var focusedField: Field!

    init(firstResult: Float = 0, secondResult: Int = 0, secondResultSave: Int = 0, secondResultMore: Int = 0) {
        self.firstResult = firstResult
        self.secondResult = secondResult
    }
    // MARK: - Visual part of code
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(spacing: 6) {
                            VStack {
                                Image(.image3)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: 130)
                                    .clipped()
                            }
                            VStack(alignment: .leading, spacing: 15) {
                                VStack {
                                    VStack(alignment: .leading) {
                                        Spacer()
                                        Text("Gender")
                                            .headers()
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
                                            .headers()
                                        Picker("Animal", selection: $selectedActivity) {
                                            ForEach(Activity.allCases) { activity in
                                                Text(activity.rawValue)
                                            }
                                        }.pickerListStyle()
                                    }
                                    VStack {
                                        VStack(alignment: .leading) {
                                            Text("Age")
                                                .headers()
                                            TextField("Select your age", text: $textInputAge)
                                                .focused($focusedField, equals: .textInputAge)
                                                .keyboardType(.numberPad)
                                                .textFieldModifier()
                                        }
                                        VStack(alignment: .leading) {
                                            Text("Height")
                                                .headers()
                                            TextField("Tape your height", text: $textInputHeight)
                                                .focused($focusedField, equals: .textInputHeight)
                                                .keyboardType(.numberPad)
                                                .textFieldModifier()
                                        }
                                        VStack(alignment: .leading) {
                                            Text("Weight")
                                                .headers()
                                            TextField("Tape your weight", text: $textInputWeight)
                                                .focused($focusedField, equals: .textInputWeight)
                                                .keyboardType(.numberPad)
                                                .textFieldModifier()
                                        }
                                    }
                                    VStack {
                                        Rectangle()
                                            .frame(width: 361, height: 0)
                                        if isTextVisible {
                                            VStack(alignment: .leading, spacing: 10) {
                                                Text("Weight: ")
                                                    .font(.custom("STIXTwoText_SemiBold", size: 20))
                                                    .foregroundStyle(.button)
                                                Text("\(secondResult) kcal - for weight maintenance")
                                                Text("\(secondResultMore) kcal - for safe weigth loss")
                                                Text("\(secondResultSave) kcal - for safe weight gain")
                                            }
                                            .padding()
                                        }
                                        Button {
                                            calculateTotalCaloriesWithoutActivity()
                                            isTextVisible.toggle()
                                        } label: {
                                            HStack {
                                                Text("Continue")
                                                    .font(.custom("AvenirNext-Regular", size: 18))
                                            }.padding(EdgeInsets(top: 15, leading: 140, bottom: 15, trailing: 140))

                                        }.buttonStyle(.myButtonStyle)

                                    }
                                }
                            }
                        }.navigationTitle("Calories")
                            .frame(minHeight: geometry.size.height)
                            .frame(idealWidth: geometry.size.width)
                            .padding(.horizontal, 16)
                    }.scrollDismissesKeyboard(.immediately)
                }
            }
        }
    }
    // MARK: - Func to valculate calories
    private func calculateTotalCaloriesWithoutActivity() {
        guard let age = Double(textInputAge),
              let weight = Double(textInputWeight),
              let height = Double(textInputHeight) else {
            print("Ошибка: введены неверные данные")
            return
        }

        switch selectedGender {
        case .femaleGender:
            firstResult = 447.593 + Float((9.247 * weight)) + Float((3.098 * height) - (4.330 * age))
        case .maleGender:
            firstResult = 88.362 + Float(13.397 * weight) + Float(4.799 * height) - Float(5.677 * age)
        }

        let activityMultiplier: Float
        switch selectedActivity {
        case .minimal:
            activityMultiplier = 1.2
        case .low:
            activityMultiplier = 1.375
        case .medium:
            activityMultiplier = 1.55
        case .high:
            activityMultiplier = 1.725
        case .veryHigh:
            activityMultiplier = 1.9
        }

        secondResult = Int(firstResult * activityMultiplier)
        secondResultSave = Int(Double(secondResult) + 500)
        secondResultMore = Int(Double(secondResult) - 400)
    }
}
struct CalculatorCalories_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorCalories()
    }
}
