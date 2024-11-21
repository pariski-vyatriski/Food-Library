//
//  TextStyle.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.
//

import SwiftUI

struct NotMainText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("AvenirNext-Regular", size: 16))
            .foregroundColor(.secondText)
    }
}

extension View {
    func notMainText() -> some View {
        self.modifier(NotMainText())
    }
}

struct NotMainTextGray: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("AvenirNext-Medium", size: 18))
            .foregroundColor(.secondText)
    }
}

extension View {
    func notMainTextGray() -> some View {
        self.modifier(NotMainText())
    }
}

struct MainTextBlackBig: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("AvenirNext-Bold", size: 24))
            .foregroundStyle(.color)

    }
}

extension View {
    func mainTextBlackBig() -> some View {
        self.modifier(MainTextBlackBig())
    }
}

struct Headers: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom("AvenirNext-Medium", size: 16))
            .foregroundColor(.color)
    }
}

extension View {
    func headers() -> some View {
        self.modifier(Headers())
    }
}
