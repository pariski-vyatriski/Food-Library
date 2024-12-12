//
//  FirstScreen.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.
//

import SwiftUI

struct ThirdScreen: View {
    @State private var showingNextScreen = false
    var body: some View {
        VStack {
            GeometryReader { proxy in
                let size = proxy.size
                VStack {
                    Image(.imageFive)
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text("Nutrition Analyzer")
                        .mainTextBlackBig()
                    
                    Rectangle()
                        .frame(width: 361, height: 0)
                    
                    VStack {
                        Text("Calculate the nutritional value of a dish based on weight of ingridients" )
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
                            .frame(width: size.width * 0.9, height: size.height * 0.08)
                    })
                    .fullScreenCover(isPresented: $showingNextScreen) {
                        FirstTabBar()
                    }
                    .buttonStyle(MyButtonStyle())
                }.frame(height: size.height * 0.9)
            }
        }
    }
}
struct ThirdScreen_Previews: PreviewProvider {
    static var previews: some View {
        ThirdScreen()
    }
}
