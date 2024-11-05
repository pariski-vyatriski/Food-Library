//
//  CalculatorVeight.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.

import SwiftUI

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
                                        .font(.custom("SFPro-Bold", size: 18))
                                    Picker("Animal", selection: $selectedProduct) {
                                        ForEach(Product.allCases) { product in
                                            Text(product.rawValue).tag(selectedProduct)
                                        }
                                    }.pickerListStyle()
                                }

                                VStack(alignment: .leading) {
                                    Text("Measurement Parametr")
                                        .font(.custom("SFPro-Bold", size: 18))
                                    Picker("Choose", selection: $selectedParametr) {
                                        ForEach(SideOfTypeParametr.allCases, id: \.self) {
                                            Text($0.rawValue).tag(selectedParametr)
                                        }
                                    }.frame(maxWidth: .infinity)
                                        .background(.second)
                                        .cornerRadius(9)
                                        .pickerStyle(SegmentedPickerStyle())

                                }

                                VStack(alignment: .leading) {
                                    Text("Quanity")
                                        .font(.custom("SFPro-Bold", size: 18))
                                    TextField("0", text: $quanity)
                                        .focused($focusedField, equals: .quanity)
                                        .keyboardType(.decimalPad)
                                        .textFieldModifier()
                                    Picker("Animal", selection: $quanityTypeVeight) {
                                        ForEach(QuanityTypeOfVeight.allCases) { quanitytypeveight in
                                            Text(quanitytypeveight.rawValue).tag(quanitytypeveight)
                                        }
                                    }.pickerListStyle()
                                }.toolbar {
                                    ToolbarItem(placement: .keyboard) {
                                        Button("Done") {
                                            focusedField = nil
                                        }
                                    }
                                }

                                VStack(alignment: .leading) {
                                    Text("What to count into")
                                        .font(.custom("SFPro-Bold", size: 18))
                                    Picker("Animal", selection: $convertInto) {
                                        ForEach(ConvertInto.allCases) { convert in
                                            Text(convert.rawValue).tag(convertInto)
                                        }
                                    }.pickerListStyle()

                                }

                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("=")
                                            .font(.custom("=", size: 20))
                                            .frame(alignment: .leading)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(1)

                                    Button(action: {
                                        isImageOne.toggle()
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
}
    enum SideOfTypeParametr: String, CaseIterable, Identifiable {
        case veight = "Veight"
        case volue = "Volume"
        var id: Self { self }
    }

    enum Product: String, CaseIterable, Identifiable {
        case cocoaPowder = "Cocoa Powder"
        case cream = "Cream"
        case flour = "Flour"
        case gelatin = "Gelatin (powder)"
        case milk = "Milk"
        case rice = "Rice (raw rice)"
        case sourCream = "Sour cream"
        case starch = "Starch"
        case sugar = "Sugar (granulated)"
        case water = "Water"
        var id: Self { self }
    }

    enum QuanityTypeOfVeight: String, CaseIterable, Identifiable {
        case gramVeight = "Gram"
        case kilogramVeight = "Kilogram"
        case ounceVeight = "Ounce"
        case poundVeight = "Ib."
        case litrVolume = "Litr"
        case mililiterVolume = "Mililiter"
        case glassVolume = "Glass 200 ml."
        case tablespoonVolume = "Tablespoon"
        case teaspoonVolume = "Teaspoon"
        var id: Self { self }
    }

    enum ConvertInto: String, CaseIterable, Identifiable {
        case gram = "Gram"
        case kilogram = "Kilogram"
        case liter = "Liter"
        case mililiter = "Mililiter"
        case glass = "Glass 200 ml"
        case tablespoon = "Tablespoon"
        case ounce = "Ounce"
        case pound = "Pound"
        case teaspoon = "Teaspoon"
        var id: Self { self }
    }

    struct CalculatorVeight_Previews: PreviewProvider {
        static var previews: some View {
            CalculatorVeight()
        }
    }
