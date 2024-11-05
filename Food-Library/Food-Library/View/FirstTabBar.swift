//
//  FirstTabBar.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.
//

import SwiftUI

struct FirstTabBar: View {
    @Binding var selectedIndex: Bool
    var body: some View {
        TabView {
            CalculatorVeight()
                .tabItem {
                    Image("scales")

                }

            CalculatorCalories()
                .tabItem {
                    Image("calories")

                }
            Saved()
                .tabItem {
                    Image("saved")
                }
            Nuttri()
                .tabItem {
                    Image(systemName: "computer")
                }
            //            ViewController()
            //                .tabItem {
            //                    Image("saved")
            //                }
        }
    }
}

struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            Nuttri()
        }
    }
}
