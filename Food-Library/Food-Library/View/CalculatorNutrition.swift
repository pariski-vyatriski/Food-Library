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
            VStack {
                TextField("Enter product or ingredients of the dish", text: $foodItem)
                    .textFieldModifier()
                    .padding()

                Button("Analyze") {
                    fetchNutritionData(for: foodItem)
                }
                .buttonStyle(.myButtonStyle)


                .disabled(isLoading)

                if isLoading {
                    ProgressView("Loading...")
                } else {
                    Text(nutritionInfo)
                        .padding()
                        .foregroundColor(.black)
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationTitle("Nutrition Analyzer")
            .padding()
        }
    }

    func fetchNutritionData(for foodItem: String) {
        guard !foodItem.isEmpty else {
            nutritionInfo = ""
            errorMessage = "Please enter a food item."
            return
        }

        let encodedItem = foodItem.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.edamam.com/api/nutrition-data?app_id=\(appId)&app_key=\(appKey)&ingr=\(encodedItem)"
        guard let url = URL(string: urlString) else { return }

        isLoading = true
        errorMessage = nil

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else { return }

            do {
                let nutritionData = try JSONDecoder().decode(NutritionResponse.self, from: data)
                DispatchQueue.main.async {
                    self.nutritionInfo = self.formatNutritionData(nutritionData)
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Error decoding data."
                }
            }
        }
        task.resume()
    }

    func formatNutritionData(_ data: NutritionResponse) -> String {
        return """
        Calories: \(data.calories) kkal
        Total Weight: \(data.totalWeight) gr.
        """
    }
}

// MARK: - Nutrition Response Model

struct NutritionResponse: Codable {
    let calories: Int
    let totalWeight: Double
}
struct Nuttri_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorNutrition()
    }
}


