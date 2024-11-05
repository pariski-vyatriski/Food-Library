//
//  PickerListStyle.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.
//

import SwiftUI

struct PickerListStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .frame(maxWidth: .infinity, maxHeight: 40)
            .background(.second)
            .cornerRadius(9)
            .shadow(radius: 1)
            .textStyle()
            .foregroundColor(.black)
            .accentColor(.black)
    }
}

extension View {
    func pickerListStyle() -> some View {
        self.modifier(PickerListStyle())
    }
}
