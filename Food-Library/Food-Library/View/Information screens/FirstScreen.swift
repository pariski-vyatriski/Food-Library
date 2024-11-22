//
//  FirstScreen.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.
//

import SwiftUI

struct FisrtScreen: View {
    @State private var showingNextScreen = false
    var body: some View {
        VStack {
            Image(.imageOne)
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Food Library")
                .mainTextBlackBig()

            Rectangle()
                .frame(width: 361, height: 0)

            VStack {
                Text("No scales? Calculator converts gr. to ml. for better cooking" )
            }.notMainTextGray()
                .frame(width: 249)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                self.showingNextScreen.toggle()
            }, label: {
                Text("Continue")
                    .font(.custom("AvenirNext-Regular", size: 18))
                    .padding(EdgeInsets(top: 15, leading: 140, bottom: 15, trailing: 140))
            })
            .fullScreenCover(isPresented: $showingNextScreen) {
                SecondScreen()
            }
            .buttonStyle(MyButtonStyle())
        }
    }
}
