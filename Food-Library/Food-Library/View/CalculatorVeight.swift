//  CalculatorVeight.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.

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
                                    }.pickerListStyle()
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
                                }
                                VStack(alignment: .leading) {
                                    Text("Quanity")
                                        .textStyle()
                                    TextField("0", text: $quanity)
                                        .focused($focusedField, equals: .quanity)
                                        .keyboardType(.decimalPad)
                                        .textFieldModifier()
                                    if selectedParametr == .weight {
                                        Picker("Weight", selection: $weightType) {
                                            ForEach(QuantityTypeOfWeight.allCases, id: \.self) { weight in
                                                Text(weight.rawValue).tag(weight)
                                            }
                                        }
                                        .pickerListStyle()
                                    } else {
                                        Picker("Volume", selection: $volumeType) {
                                            ForEach(QuantityTypeOfVolume.allCases, id: \.self) { volume in
                                                Text(volume.rawValue).tag(volume)
                                            }
                                        }
                                        .pickerListStyle()
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
                                }

                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("= ")
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
}


struct CalculatorVeight_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorVeight()
    }
}

