import SwiftUI
import CoreData

struct CalculatorVeight: View {
    @State private var countInto = ""
    @State private var textInput = ""
    @State private var quanity = ""
    @State private var selectedProduct = Product.cocoaPowder
    @State private var convertInto = ConvertInto.gram
    @State private var isImageOne: Bool = true
    @FocusState private var focusedField: Field?
    @State private var scalesName: String = ""
    @State private var scalesValue: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    private enum Field: Int, CaseIterable {
        case quanity
    }
    @State private var isClick = true
    @State private var result: Float = 0.0
    @State private var isValidInput = false
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
    // MARK: - Create visual part of screen
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
                                    .frame(maxWidth: .infinity, maxHeight: 150)
                                    .clipped()
                            }
                            VStack(alignment: .leading, spacing: 15) {

                                VStack(alignment: .leading) {
                                    Text("Product")
                                        .headers()
                                    Picker("Product", selection: $selectedProduct) {
                                        ForEach(Product.allCases) { product in
                                            Text(product.rawValue).tag(product)
                                        }
                                    }
                                    .pickerListStyle()
                                    .onChange(of: selectedProduct) {
                                        calculateVeight()
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text("Measurement Parameter")
                                        .headers()
                                    Picker("Measurement Type", selection: $selectedParametr) {
                                        ForEach(MeasurementCategory.allCases, id: \.self) { parametr in
                                            Text(parametr.rawValue).tag(parametr)
                                        }
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                                    .frame(maxWidth: .infinity)
                                    .background(Color.second)
                                    .cornerRadius(9)
                                    .onChange(of: selectedParametr) {
                                        calculateVeight()
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text("Quantity")
                                        .headers()
                                    TextField("0", text: $quanity)
                                        .keyboardType(.numberPad)
                                        .textFieldModifier()
                                        .focused($focusedField, equals: .quanity)
                                        .onChange(of: quanity) {
                                            handleQuanityChange()
                                        }

                                    if selectedParametr == .weight {
                                        Picker("Weight", selection: $weightType) {
                                            ForEach(QuantityTypeOfWeight.allCases, id: \.self) { weight in
                                                Text(weight.rawValue).tag(weight)
                                            }
                                        }
                                        .pickerListStyle()
                                        .onChange(of: weightType) {
                                            calculateVeight()
                                        }
                                    } else {
                                        Picker("Volume", selection: $volumeType) {
                                            ForEach(QuantityTypeOfVolume.allCases, id: \.self) { volume in
                                                Text(volume.rawValue).tag(volume)
                                            }
                                        }
                                        .pickerListStyle()
                                        .onChange(of: volumeType) {
                                            calculateVeight()
                                        }
                                    }
                                }
                                VStack(alignment: .leading) {
                                    Text("What to count into")
                                        .headers()
                                    Picker("What to count into", selection: $convertInto) {
                                        ForEach(ConvertInto.allCases) { convert in
                                            Text(convert.rawValue).tag(convert)
                                        }
                                    }
                                    .pickerListStyle()
                                    .onChange(of: convertInto) {
                                        calculateVeight()
                                    }
                                }

                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("= \(result)")
                                            .headers()
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
                                    }, label: {
                                        Image(isImageOne ? "star" : "two")
                                            .frame(width: 8, height: 9)
                                            .padding()
                                            .cornerRadius(8)
                                    })
                                }
                                .frame(maxWidth: .infinity, maxHeight: 30)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                        .foregroundColor(.gray)
                                )

                                Rectangle()
                                    .frame(width: 361, height: 0)
                            }
                        }
                        .navigationTitle("Scales")
                        .frame(minHeight: geometry.size.height)
                        .frame(idealWidth: geometry.size.width)
                        .padding(.horizontal, 16)
                    }.scrollDismissesKeyboard(.immediately)
                }
            }
        }
    }
    // MARK: - Function to calculate product density
    func getProductDensity(for product: Product) -> Float {
        switch product {
        case .cocoaPowder: return 0.65
        case .cream: return 1.03
        case .flour: return 0.7
        case .gelatin: return 1.3
        case .milk: return 1.03
        case .rice: return 0.78
        case .sourCream: return 1.05
        case .starch: return 0.65
        case .sugar: return 0.9
        case .water: return 1.0
        }
    }
    // MARK: - Function to calculate weight
    func calculateWeight(quantity: Float, weightType: QuantityTypeOfWeight) -> Float {
        switch weightType {
        case .gram: return quantity / 1000
        case .kilogram: return quantity
        case .ounce: return quantity * 0.0283495
        case .pound: return quantity * 0.453592
        }
    }
    // MARK: - Function to calculate volume
    func calculateVolume(quantity: Float, volumeType: QuantityTypeOfVolume) -> Float {
        switch volumeType {
        case .liter: return quantity
        case .milliliter: return quantity / 1000
        case .glass: return quantity * 0.24
        case .tablespoon: return quantity * 15 / 1000
        case .teaspoon: return quantity * 5 / 1000
        }
    }
    // MARK: - Function to convert units
    func convertToDesiredUnits(weight: Float, volume: Float, convertInto: ConvertInto) -> Float {
        switch convertInto {
        case .gram: return weight * 1000
        case .kilogram: return weight
        case .liter: return volume
        case .mililiter: return volume * 1000
        case .glass: return volume * 4.22675
        case .tablespoon: return volume * 67.628
        case .ounce: return volume * 33.814
        case .pound: return weight * 2.20462
        case .teaspoon: return volume * 202.88
        }
    }
    // MARK: - Function to calculate weight and volume
    func calculateVeight() {

        let productDensity = getProductDensity(for: selectedProduct)
        guard let quantityValue = Float(quanity), quantityValue > 0 else {
            print("Ошибка: Некорректное количество: \(quanity)")
            return
        }

        var totalWeight: Float = 0.0
        var totalVolume: Float = 0.0

        if selectedParametr == .weight {
            totalWeight = calculateWeight(quantity: quantityValue, weightType: weightType)
            totalVolume = totalWeight / productDensity
        } else if selectedParametr == .volume {
            totalVolume = calculateVolume(quantity: quantityValue, volumeType: volumeType)
            totalWeight = totalVolume * productDensity
        }

        let calculationResult = convertToDesiredUnits(
            weight: totalWeight,
            volume: totalVolume,
            convertInto: convertInto
        )

        DispatchQueue.main.async {
            self.result = calculationResult
            print("Result updated: \(calculationResult)")
        }
    }

    // MARK: - Function to validate quantity input
    private func handleQuanityChange() {
        guard let quantityValue = Float(quanity), quantityValue > 0 else {
            isValidInput = false
            result = 0.0
            return
        }
        isValidInput = true
        calculateVeight()
    }
}

extension CalculatorVeight {
    // MARK: - Function to add favorite scales to CoreData
    func addScales() {
        let productName = selectedProduct.rawValue
        let quantityText = quanity
        let weightTypeText = weightType.rawValue
        let volumeTypeText = volumeType.rawValue
        let resultSave = String(result)
        let conversionTypeText = convertInto.rawValue
        var resultText: String

        let calculationDescription = "Product: \(productName)"
        if selectedParametr == .weight {
            resultText = "\(quantityText) \(weightTypeText) = \(resultSave) \(conversionTypeText)"
        } else {
            resultText = "\(quantityText) \(volumeTypeText) = \(resultSave) \(conversionTypeText)"
        }

        let newScales = Scales(context: viewContext)
        newScales.name = calculationDescription
        newScales.value = resultText

        do {
            try viewContext.save()
            print("Scales saved successfully with description")
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
}
