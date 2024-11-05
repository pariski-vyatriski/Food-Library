//
//  TextStyle.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.
//

import SwiftUI

struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("STIXTwoText", size: 18))
    }
}

extension View {
    func textStyle() -> some View {
        self.modifier(TextStyle())
    }
}

struct TextStyleMain: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("STIXTwoText_SemiBold", size: 30))
    }
}

extension View {
    func textStylemain() -> some View {
        self.modifier(TextStyleMain())
    }
}

struct NotMainText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("STIXTwoText_SemiBold", size: 20))
            .foregroundColor(.gray)
    }
}

extension View {
    func notMainText() -> some View {
        self.modifier(NotMainText())
    }
}
