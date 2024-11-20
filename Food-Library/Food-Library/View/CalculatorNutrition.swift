import SwiftUI

struct CalculatorNutrition: View {
    @State private var foodItem: String = ""
    @State private var nutritionInfo: String = ""
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    let appId = "1bbd39ab"
    let appKey = "ccfae710b9f226c001280a643b0915f4"

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Image("ImageThree")
                    Text("""
                Calculate the nutritional value of a
                    dish based on weight of ingredients
                """)
                    .notMainText()

                    TextField("Example: 100 gr. of rice, 250 ml of milk", text: $foodItem)
                        .textFieldModifier()
                        .padding()
                    Text("The market days are \(Text("Wednesday").bold()) and \(Text("Sunday").bold()).")

                    Button {
                        fetchNutritionData(for: foodItem)
                    } label: {
                        HStack {
                            Text("Calculate")
                                .font(.custom("SFPro-Bold", size: 18))
                        }
                        .padding(EdgeInsets(top: 15, leading: 140, bottom: 15, trailing: 140))
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

    // Fetching data from API
    func fetchNutritionData(for foodItem: String) {
        guard !foodItem.isEmpty else {
            nutritionInfo = ""
            errorMessage = "Please enter a food item."
            return
        }

        let encodedItem = foodItem.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.edamam.com/api/nutrition-data?app_id=\(appId)" +
        "&app_key=\(appKey)&ingr=\(encodedItem)"
        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL"
            return
        }

        isLoading = true
        errorMessage = nil

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received."
                }
                return
            }

            // Print raw response data for debugging
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Received data: \(jsonString)")
            }

            do {
                let nutritionData = try JSONDecoder().decode(NutritionResponse.self, from: data)
                DispatchQueue.main.async {
                    self.nutritionInfo = self.formatNutritionData(nutritionData)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Error decoding data: \(error.localizedDescription)"
                }
            }
        }
        task.resume()
    }

    func formatNutritionData(_ data: NutritionResponse) -> String {
        var result = """
        Total Weight: \(data.totalWeight) gr.
        Calories: \(data.calories) kkal
        """
        if let nutrients = data.totalNutrients {
            if let fat = nutrients.fat {
                result += "\nFat: \(fat.quantity) \(fat.unit)"
            }
            if let carbs = nutrients.carbs {
                result += "\nCarbs: \(carbs.quantity) \(carbs.unit)"
            }
            if let protein = nutrients.protein {
                result += "\nProtein: \(protein.quantity) \(protein.unit)"
            }
        }
        return result
    }
}

// MARK: - Nutrition Response Model

struct NutritionResponse: Codable {
    let calories: Int
    let totalWeight: Double
    let totalNutrients: Nutrients?

    struct Nutrients: Codable {
        let fat: Nutrient?
        let carbs: Nutrient?
        let protein: Nutrient?

        enum CodingKeys: String, CodingKey {
            case fat = "FAT"
            case carbs = "CHOCDF"
            case protein = "PROCNT"
        }

        struct Nutrient: Codable {
            let label: String
            let quantity: Double
            let unit: String
        }
    }
}

// MARK: - Previews

struct Nuttri_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorNutrition()
    }
}
