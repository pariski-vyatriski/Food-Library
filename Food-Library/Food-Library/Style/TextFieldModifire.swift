//
//  TextFieldModifire.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("AvenirNext-Regular", size: 14))
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(.second)
            .cornerRadius(9)
            .shadow(radius: 1)
            .foregroundColor(.black)
    }
}

extension View {
    func textFieldModifier() -> some View {
        self.modifier(TextFieldModifier())
    }
}
