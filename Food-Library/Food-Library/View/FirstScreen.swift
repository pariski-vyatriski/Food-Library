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
        //        NavigationView {
        VStack {
            Image(.imageOne)
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Food Library")
                .textStylemain()

            Rectangle()
                .frame(width: 361, height: 0)

            VStack {
                Text("Some text about funcionality and goodies of our app " )
            }.notMainText()
                .frame(width: 249)
                .lineLimit(3)
                .multilineTextAlignment(.center)
            Button(action: {
                self.showingNextScreen.toggle()
            }) {
                Text("Continue")
                    .font(.custom("SFPro-Bold", size: 18))
                    .padding(EdgeInsets(top: 15, leading: 140, bottom: 15, trailing: 140))
            } .fullScreenCover(isPresented: $showingNextScreen) {
                FirstTabBar(selectedIndex: $showingNextScreen)}
            .buttonStyle(MyButtonStyle())
        }
    }
}
