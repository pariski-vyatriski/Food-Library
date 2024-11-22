//
//  enum.swift
//  Food-Library
//
//  Created by apple on 5.11.24.
//

import SwiftUI

// MARK: - enum for CalculatorVeight
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

enum MeasurementCategory: String, CaseIterable, Identifiable {
    case weight = "Weight"
    case volume = "Volume"
    var id: Self { self }
}

enum QuantityTypeOfWeight: String, CaseIterable, Identifiable {
    case gram = "Gram"
    case kilogram = "Kilogram"
    case ounce = "Ounce"
    case pound = "Ib."
    var id: Self { self }
}

enum QuantityTypeOfVolume: String, CaseIterable, Identifiable {
    case liter = "Litre"
    case milliliter = "Milliliter"
    case glass = "Glass 200 ml."
    case tablespoon = "Tablespoon"
    case teaspoon = "Teaspoon"
    var id: Self { self }
}
// MARK: - enum for CalculatorCalories
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
