import SwiftUI

struct CalculatorNutrition: View {
    @State private var foodItem: String = ""
    @State private var nutritionInfo: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?
    @State private var totalWeight: Double = 0.0
    @State private var totalCalories: Double = 0.0
    @State private var totalFat: Double = 0.0
    @State private var totalCarbs: Double = 0.0
    @State private var totalProtein: Double = 0.0

    let appId = "1bbd39ab"
    let appKey = "ccfae710b9f226c001280a643b0915f4"

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                let size = proxy.size
                ScrollView {
                    VStack {
                        Image("ImageThree")
                        Text("Calculate the nutritional value of ingredients")
                            .notMainText()
                            .multilineTextAlignment(.center)
                        
                        TextField("Example: 100 gr. of rice", text: $foodItem)
                            .textFieldModifier()
                            .padding()
                        
                        Button {
                            let ingredients = foodItem.split(separator: ",").map { String($0).trimmingCharacters(in: .whitespacesAndNewlines) }
                            fetchNutritionData(for: ingredients)
                        } label: {
                            HStack {
                                Text("Calculate")
                                    .font(.custom("AvenirNext-Regular", size: 18))
                            }
                            .frame(width: size.width * 0.9, height: size.height * 0.08)
                        }
                        .buttonStyle(.myButtonStyle)
                        .disabled(isLoading)
                        
                        if isLoading {
                            ProgressView("Loading...")
                        } else {
                            VStack(alignment: .leading) {
                                if !nutritionInfo.isEmpty {
                                    Text(nutritionInfo)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
                                                .foregroundColor(.gray)
                                        )
                                }
                                if let errorMessage = errorMessage {
                                    Text(errorMessage)
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                    .navigationTitle("Nutrition Analyzer")
                    .padding()
                }
                .scrollDismissesKeyboard(.immediately)
            }
        }
    }
// MARK: work with data
    func fetchNutritionData(for ingredients: [String]) {
        guard !ingredients.isEmpty else {
            nutritionInfo = ""
            errorMessage = "Please enter an ingredient."
            return
        }

        isLoading = true
        errorMessage = nil

        var nutritionResults = [String]()

        totalWeight = 0.0
        totalCalories = 0.0

        let group = DispatchGroup()

        for ingredient in ingredients {
            group.enter()

            let encodedItem = ingredient.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlString = "https://api.edamam.com/api/nutrition-data?app_id=\(appId)" +
            "&app_key=\(appKey)&ingr=\(encodedItem)"

            guard let url = URL(string: urlString) else {
                DispatchQueue.main.async {
                    self.errorMessage = "Invalid URL"
                }
                group.leave()
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = "Error: \(error.localizedDescription)"
                    }
                    group.leave()
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        self.errorMessage = "No data received."
                    }
                    group.leave()
                    return
                }

                do {
                    let nutritionData = try JSONDecoder().decode(NutritionResponse.self, from: data)
                    let formattedData = self.formatNutritionData(nutritionData, ingredient: ingredient)
                    DispatchQueue.main.async {
                        nutritionResults.append(formattedData)

                        if let totalWeight = nutritionData.totalWeight {
                            self.totalWeight += totalWeight
                        }
                        if let calories = nutritionData.calories {
                            self.totalCalories += calories
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Error decoding data: \(error.localizedDescription)"
                    }
                }
                group.leave()
            }

            task.resume()
        }

        group.notify(queue: .main) {
            if !nutritionResults.isEmpty {
                self.nutritionInfo = nutritionResults.joined(separator: "\n\n")
                self.nutritionInfo += "\n\nTotal Nutrition for all ingredients:\n"
                self.nutritionInfo += "Total Weight: \(self.totalWeight) gr.\n"
                self.nutritionInfo += "Total Calories: \(self.totalCalories) kkal\n"
            } else {
                self.nutritionInfo = "No valid nutrition data found."
            }
            self.isLoading = false
        }
    }

    func formatNutritionData(_ data: NutritionResponse, ingredient: String) -> String {
        var result = "\(ingredient):\n"

        if let totalWeight = data.totalWeight, !totalWeight.isNaN {
            result += "Total Weight: \(totalWeight) gr.\n"
        } else {
            result += "Total Weight: unknown\n"
        }

        if let calories = data.calories, !calories.isNaN {
            result += "Calories: \(calories) kkal\n"
        } else {
            result += "Calories: unknown\n"
        }
        return result
    }
}

// MARK: - Nutrition Response Model

struct NutritionResponse: Codable {
    let calories: Double?
    let totalWeight: Double?

    struct Nutrient: Codable {
        let label: String
        let quantity: Double?
        let unit: String
    }
}
