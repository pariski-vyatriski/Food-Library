import SwiftUI

struct FirstTabBar: View {
    @State private var isImageVeightActive = false
    @State private var isImageCaloriesActive = false
    @State private var isImageSavedActive = false
    @State private var isImageNutritionActive = false
    @State private var isImageSettingsActive = false

    var body: some View {
        TabView {
            CalculatorVeight()
                .tabItem {
                    Image(isImageVeightActive ? "scalesActive" : "scales")
                }
                .onAppear {
                    isImageVeightActive = true
                }
                .onDisappear {
                    isImageVeightActive = false
                }
            CalculatorCalories()
                .tabItem {
                    Image(isImageCaloriesActive ? "caloriesActive" : "calories")
                }
                .onAppear {
                    isImageCaloriesActive = true
                }
                .onDisappear {
                    isImageCaloriesActive = false
                }
            Saved()
                .tabItem {
                    Image(isImageSavedActive ? "savedActive" : "saved")
                }
                .onAppear {
                    isImageSavedActive = true
                }
                .onDisappear {
                    isImageSavedActive = false
                }
            CalculatorNutrition()
                .tabItem {
                    Image(isImageNutritionActive ? "nutritionActive" : "nutrition")
                }
                .onAppear {
                    isImageNutritionActive = true
                }
                .onDisappear {
                    isImageNutritionActive = false
                }
            Settings()
                .tabItem {
                    Image(isImageSettingsActive ? "settingsActive" : "settings")
                }
                .onAppear {
                    isImageSettingsActive = true
                }
                .onDisappear {
                    isImageSettingsActive = false
                }
        }
    }
}

struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            FirstTabBar()
        }
    }
}
