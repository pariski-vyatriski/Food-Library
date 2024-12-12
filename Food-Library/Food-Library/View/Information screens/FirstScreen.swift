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
            GeometryReader { proxy in
                let size = proxy.size
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

                    HStack {
                        Button(action: {
                            self.showingNextScreen.toggle()
                        }, label: {
                            Text("Continue")
                                .font(.custom("AvenirNext-Regular", size: 18))
                            //                        .padding(EdgeInsets(top: 12, leading: 104, bottom: 12, trailing: 104))
                                .frame(width: size.width * 0.9, height: size.height * 0.08)
                        })
                        .fullScreenCover(isPresented: $showingNextScreen) {
                            SecondScreen()
                        }
                        .buttonStyle(MyButtonStyle())
                    }
                }.frame(height: size.height * 0.9)
            }
        }
    }
}
struct FirstScreen_Previews: PreviewProvider {
  static var previews: some View {
      FisrtScreen()
  }
}
