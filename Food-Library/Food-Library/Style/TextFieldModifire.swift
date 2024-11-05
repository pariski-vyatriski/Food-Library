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
//            .frame(maxWidth: 361)
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(.second)
            .cornerRadius(9)
            .shadow(radius: 1)
            .font(.system(size: 14))
            .foregroundColor(.black)
    }
}

extension View {
    func textFieldModifier() -> some View {
        self.modifier(TextFieldModifier())
    }
}
