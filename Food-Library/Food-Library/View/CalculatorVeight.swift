//
//  CalculatorVeight.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.

import SwiftUI
import CoreData

struct CalculatorVeight: View {
    @State private var countInto = ""
    @State private var selectedParametr: SideOfTypeParametr = .veight
    @State private var textInput = ""
    @State private var quanity = ""
    @State private var selectedProduct = Product.cocoaPowder
    @State private var quanityTypeVeight = QuanityTypeOfVeight.gramVeight
    @State private var convertInto = ConvertInto.gram
    @State private var isImageOne: Bool = true
    @FocusState private var focusedField: Field?
    @State private var scalesName: String = ""
    @Environment(\.managedObjectContext) private var viewContext
    private enum Field: Int, CaseIterable {
        case quanity
    }
    @State private var isClick = true

    private var measurementParametr: [String] {
        switch selectedParametr {
        case .veight:
            return QuanityTypeOfVeight.allCases.map { $0.rawValue}
        case .volume:
            return QuanityTypeOfVolume.allCases.map { $0.rawValue}
        }
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
                                    Picker("Animal", selection: $selectedProduct) {
                                        ForEach(Product.allCases) { product in
                                            Text(product.rawValue).tag(selectedProduct)
                                        }
                                    }.pickerListStyle()
                                }

                                VStack(alignment: .leading) {
                                    Text("Measurement Parametr")
                                        .textStyle()
                                    Picker("Product", selection: $selectedParametr) {
                                        ForEach(SideOfTypeParametr.allCases) { product in
                                            Text(product.rawValue).tag(product)
                                        }
                                    }
                                    .frame(maxWidth: .infinity)
                                    .background(.second)
                                    .cornerRadius(9)
                                    .pickerStyle(SegmentedPickerStyle())

                                }

                                VStack(alignment: .leading) {
                                    Text("Quanity")
                                        .textStyle()
                                    TextField("0", text: $quanity)
                                        .focused($focusedField, equals: .quanity)
                                        .keyboardType(.decimalPad)
                                        .textFieldModifier()
                                    Picker("Measurement", selection: $quanityTypeVeight) {
                                        ForEach(measurementParametr, id: \.self) { measurement in
                                            Text(measurement).tag(measurement)
                                        }
                                    }
                                    .pickerListStyle()
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
                                    Picker("Animal", selection: $convertInto) {
                                        ForEach(ConvertInto.allCases) { convert in
                                            Text(convert.rawValue).tag(convertInto)
                                        }
                                    }.pickerListStyle()

                                }

                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("=")
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
    //MARK: - function to calculate result
    func calculateResult() {
        ///set the density of selected product
        let productDensity: Double
        switch selectedProduct {
        case .cocoaPowder:
            productDensity = 0.55
        case .cream:
            productDensity = 1.03
        case .flour:
            productDensity = 0.59
        case .gelatin:
            productDensity = 0.7
        case .milk:
            productDensity = 1.03
        case .rice:
            productDensity = 0.9
        case .sourCream:
            productDensity = 1.03
        case .starch:
            productDensity = 0.65
        case .sugar:
            productDensity = 0.85
        case .water:
            productDensity = 1.0
        }
        /// set to

    }

}

struct CalculatorVeight_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorVeight()
    }
}
