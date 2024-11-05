//
//  MyButtonStyle.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.
//
import SwiftUI

struct MyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label

            .foregroundColor( configuration.isPressed ? .white : .white)
            .background(configuration.isPressed ? .buttonTupped : .button)

            .clipShape(RoundedRectangle(cornerSize: CGSize(width: 63, height: 63)))
            .shadow(radius: 1)
//            .frame(width: 361.0, height: 44)
            .frame(maxWidth: .infinity)
    }

}
extension ButtonStyle where Self == MyButtonStyle {
    static var myButtonStyle: MyButtonStyle {
        MyButtonStyle()
    }
}

#Preview{
    VStack {
        Button("Continue") {
            print("Continue")
        }
        .buttonStyle(.myButtonStyle)
    }
}
