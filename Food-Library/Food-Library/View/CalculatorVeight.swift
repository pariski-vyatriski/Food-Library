import SwiftUI
import CoreData

struct CalculatorVeight: View {
    @State private var isValidInput = false
    @State private var countInto = ""
    @State private var textInput = ""
    @State private var quanity = ""
    @State private var selectedProduct = Product.cocoaPowder
    @State private var convertInto = ConvertInto.gram
    @State private var isImageOne: Bool = true
    @FocusState private var focusedField: Field?
    @State private var scalesName: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    private enum Field: Int, CaseIterable {
        case quanity
    }
    @State private var isClick = true
    @State private var result: Float = 0.0

    @State private var selectedParametr: MeasurementCategory = .weight
    @State private var weightType: QuantityTypeOfWeight = .gram
    @State private var volumeType: QuantityTypeOfVolume = .liter

    private var measurementParametr: [String] {
        switch selectedParametr {
        case .weight:
            return QuantityTypeOfWeight.allCases.map { $0.rawValue }
        case .volume:
            return QuantityTypeOfVolume.allCases.map { $0.rawValue }
        }
    }
    init(result: Float = 0.0) {
        _result = State(initialValue: result)
    }

    private func handleQuanityChange() {
        // Проверка, что поле заполнено и корректно
        guard let quantityValue = Float(quanity), quantityValue > 0 else {
            isValidInput = false  // Если ввод некорректен, флаг становиться false
            return
        }
        isValidInput = true  // Если ввод корректен, флаг становиться true
        calculateVeight()    // Запуск вычислений
    }

    //MARK: - create visual part of screen
    var body: some View {
        ZStack {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        LazyVStack(spacing: 6) {
                            VStack {
                                Image(.imageTwo)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight:165)
                                    .clipped()
                            }
                            VStack(alignment: .leading, spacing: 15) {

                                VStack(alignment: .leading) {
                                    Text("Product")
                                        .textStyle()
                                    Picker("Product", selection: $selectedProduct) {
                                        ForEach(Product.allCases) { product in
                                            Text(product.rawValue).tag(product)
                                        }
                                    }
                                    .pickerListStyle()
                                    .onChange(of: selectedProduct) { _ in
                                        calculateVeight()  // Пересчитываем результат при изменении продукта
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text("Measurement Parametr")
                                        .textStyle()
                                    Picker("Measurement Type", selection: $selectedParametr) {
                                        ForEach(MeasurementCategory.allCases, id: \.self) { parametr in
                                            Text(parametr.rawValue).tag(parametr)
                                        }
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .frame(maxWidth: .infinity)
                                    .background(Color.second)
                                    .cornerRadius(9)
                                    .onChange(of: selectedParametr) { _ in
                                        calculateVeight()  // Пересчитываем результат при изменении параметра
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text("Quanity")
                                        .textStyle()
                                    TextField("0", text: $quanity)
                                        .keyboardType(.decimalPad)
                                        .textFieldModifier()
                                        .focused($focusedField, equals: .quanity)
                                        .onChange(of: quanity) { _ in
                                            handleQuanityChange()  // Пересчитываем результат при изменении количества
                                        }

                                    if !isValidInput {
                                        Text("Ошибка: Пожалуйста, введите корректное количество!")
                                            .foregroundColor(.red)
                                            .font(.footnote)
                                    }

                                    if selectedParametr == .weight {
                                        Picker("Weight", selection: $weightType) {
                                            ForEach(QuantityTypeOfWeight.allCases, id: \.self) { weight in
                                                Text(weight.rawValue).tag(weight)
                                            }
                                        }
                                        .pickerListStyle()
                                        .onChange(of: weightType) { _ in
                                            calculateVeight()  // Пересчитываем результат при изменении типа веса
                                        }
                                    } else {
                                        Picker("Volume", selection: $volumeType) {
                                            ForEach(QuantityTypeOfVolume.allCases, id: \.self) { volume in
                                                Text(volume.rawValue).tag(volume)
                                            }
                                        }
                                        .pickerListStyle()
                                        .onChange(of: volumeType) { _ in
                                            calculateVeight()  // Пересчитываем результат при изменении типа объема
                                        }
                                    }
                                }.toolbar {
                                    ToolbarItem(placement: .keyboard) {
                                        Button("Done") {
                                            focusedField = nil
                                        }
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text("What to count into")
                                        .textStyle()
                                    Picker("What to count into", selection: $convertInto) {
                                        ForEach(ConvertInto.allCases) { convert in
                                            Text(convert.rawValue).tag(convert)
                                        }
                                    }
                                    .pickerListStyle()
                                    .onChange(of: convertInto) { _ in
                                        calculateVeight()  // Пересчитываем результат при изменении единицы измерения
                                    }
                                }

                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("= \(result)")
                                            .textStyle()
                                            .frame(alignment: .leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(1)

                                    Button(action: {
                                        if isClick {
                                            addScales()
                                        }
                                        isImageOne.toggle()
                                        isClick.toggle()
                                    }) {
                                        Image(isImageOne ? "star" : "two")
                                            .frame(width: 8, height: 9)
                                            .padding()
                                            .cornerRadius(8)
                                    }
                                }.frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                            .foregroundColor(.gray)
                                    )
                                VStack(alignment: .leading) {
                                    Rectangle()
                                        .frame(width: 361, height: 0)
                                }
                            }
                        }.navigationTitle("Scales")
                            .frame(minHeight: geometry.size.height)
                            .frame(idealWidth: geometry.size.width)
                            .padding(.horizontal, 16)
                    }
                }
            }
        }
    }

    //MARK: - function to add favotite scales
    func addScales() {
        let newScales = Scales(context: viewContext)
        newScales.name = scalesName
        do {
            try viewContext.save()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }

    //MARK: - function to calculate total weight
    func calculateVeight() {
        var calculationResult: Float = 0.0
        let productDensity: Float
        var totalWeight: Float = 0.0
        var totalVolume: Float = 0.0

        // Define product density
        switch selectedProduct {
        case .cocoaPowder:
            productDensity = 0.65
        case .cream:
            productDensity = 1.03
        case .flour:
            productDensity = 0.7
        case .gelatin:
            productDensity = 1.3
        case .milk:
            productDensity = 1.03
        case .rice:
            productDensity = 0.78
        case .sourCream:
            productDensity = 1.05
        case .starch:
            productDensity = 0.65
        case .sugar:
            productDensity = 0.9
        case .water:
            productDensity = 1.0
        }

        // Handle input validation and calculation
        guard let quantityValue = Float(quanity), quantityValue > 0 else {
            print("Ошибка: Некорректное количество: \(quanity)")
            return
        }

        // Perform weight conversion
        switch weightType {
        case .gram:
            totalWeight = quantityValue / 1000
        case .kilogram:
            totalWeight = quantityValue
        case .ounce:
            totalWeight = quantityValue * 0.0283495
        case .pound:
            totalWeight = quantityValue * 0.453592
        }

        // Calculate volume or weight
        if selectedParametr == .weight {
            totalVolume = totalWeight / productDensity
        } else if selectedParametr == .volume {
            totalVolume = quantityValue
            totalWeight = totalVolume * productDensity
        }

        // Ensure non-zero volume
        if totalVolume == 0 {
            print("Ошибка: Нулевой объём! Проверьте введённые данные.")
            return
        }

        // Final conversion to the selected unit
        switch convertInto {
        case .gram:
            calculationResult = totalWeight * 1000
        case .kilogram:
            calculationResult = totalWeight
        case .liter:
            calculationResult = totalVolume
        case .mililiter:
            calculationResult = totalVolume * 1000
        case .glass:
            calculationResult = totalVolume * 4.22675
        case .tablespoon:
            calculationResult = totalVolume * 67.628
        case .ounce:
            calculationResult = totalVolume * 33.814
        case .pound:
            calculationResult = totalWeight * 2.20462
        case .teaspoon:
            calculationResult = totalVolume * 202.88
        }

        // Update result
        DispatchQueue.main.async {
            self.result = calculationResult
        }
    }
}
