//
//  SecondScreen.swift
//  Food-Library
//
//  Created by apple on 20.11.24.
//

import SwiftUI

struct SecondScreen: View {
    @State private var showingNextScreen = false
    var body: some View {
        VStack {
            Image(.imageFour)
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Calorie Counter")
                .textStylemain()

            Rectangle()
                .frame(width: 361, height: 0)

            VStack {
                Text("Learn the calorie content of foods for your optimal health" )
            }.notMainText()
                .frame(width: 249)
                .lineLimit(3)
                .multilineTextAlignment(.center)
            Button(action: {
                self.showingNextScreen.toggle()
            }, label: {
                Text("Continue")
                    .font(.custom("SFPro-Bold", size: 18))
                    .padding(EdgeInsets(top: 15, leading: 140, bottom: 15, trailing: 140))
            })
            .fullScreenCover(isPresented: $showingNextScreen) {
                ThirdScreen()
            }
            .buttonStyle(MyButtonStyle())
        }
    }
}
struct SecondScreen_Previews: PreviewProvider {
    static var previews: some View {
        SecondScreen()
    }
}
