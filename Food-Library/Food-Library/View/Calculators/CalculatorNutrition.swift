import SwiftUI

struct CalculatorNutrition: View {
    @State private var foodItem: String = ""
    @State private var nutritionInfo: [NutritionData] = []
    @State private var isLoading: Bool = false
    @State private var errorMessage: String?

    let appId = "1bbd39ab"
    let appKey = "ccfae710b9f226c001280a643b0915f4"

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let size = geometry.size
                VStack {

                    if !nutritionInfo.isEmpty {
                        Text("")
                    } else {
                        Image("ImageThree")
                    }

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
                        if let errorMessage = errorMessage {
                            Text(errorMessage)
                                .foregroundColor(.red)
                        }

                        if !nutritionInfo.isEmpty {

                            HStack {
                                Text("Product")
                                    .fontWeight(.medium)
                                    .frame(width: size.width * 0.25, alignment: .center)
                                Text("Calories")
                                    .fontWeight(.medium)
                                    .frame(width: size.width * 0.25, alignment: .center)
                                Text("Weight (gr)")
                                    .fontWeight(.medium)
                                    .frame(width: size.width * 0.25, alignment: .center)
                            }
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.button)

                            List(nutritionInfo) { item in
                                VStack {
                                    HStack {
                                        Text(item.ingredient)
                                            .frame(width: size.width * 0.25,
                                                   height: size.height * 0.15,
                                                   alignment: .center)
                                        Text("\(item.totalWeight, specifier: "%.2f") gr")
                                            .frame(width: size.width * 0.25,
                                                   height: size.height * 0.15,
                                                   alignment: .center)
                                        Text("\(item.calories, specifier: "%.2f") kkal")
                                            .frame(width: size.width * 0.25,
                                                   height: size.height * 0.15,
                                                   alignment: .center)
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .frame(maxWidth: .infinity)
                            .background(Color(.white))

                        } else {
                            Text("")
                        }
                    }
                }
                .padding(12)
                .navigationTitle("Nutrition Analyzer")
            }
        }
    }
    // MARK: - Work with data
    func fetchNutritionData(for ingredients: [String]) {
        guard !ingredients.isEmpty else {
            errorMessage = "Please enter an ingredient."
            print("No ingredients entered.")
            return
        }

        isLoading = true
        errorMessage = nil
        nutritionInfo = [] // Reset previous data
        print("Started fetching nutrition data for ingredients: \(ingredients)")

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
                print("Invalid URL: \(urlString)")
                group.leave()
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = "Error: \(error.localizedDescription)"
                    }
                    print("Error fetching data: \(error.localizedDescription)")
                    group.leave()
                    return
                }

                guard let data = data else {
                    DispatchQueue.main.async {
                        self.errorMessage = "No data received."
                    }
                    print("No data received for ingredient: \(ingredient)")
                    group.leave()
                    return
                }

                do {
                    let nutritionData = try JSONDecoder().decode(NutritionResponse.self, from: data)
                    DispatchQueue.main.async {
                        let formattedData = self.formatNutritionData(nutritionData, ingredient: ingredient)
                        nutritionInfo.append(formattedData) // Add data to nutritionInfo
                        print("Added nutrition data for \(ingredient): \(formattedData)")
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.errorMessage = "Error decoding data: \(error.localizedDescription)"
                    }
                    print("Error decoding data for ingredient \(ingredient): \(error.localizedDescription)")
                }
                group.leave()
            }

            task.resume()
        }

        group.notify(queue: .main) {
            isLoading = false
            print("Finished fetching all nutrition data.")
        }
    }

    func formatNutritionData(_ data: NutritionResponse, ingredient: String) -> NutritionData {
        let totalWeight = data.totalWeight ?? 0.0
        let calories = data.calories ?? 0.0

        let formattedData = NutritionData(ingredient: ingredient, totalWeight: totalWeight, calories: calories)
        print("Formatted nutrition data for \(ingredient): \(formattedData)")
        return formattedData
    }
}

// MARK: - Nutrition Response Model
struct NutritionResponse: Codable {
    let calories: Double?
    let totalWeight: Double?
}

// MARK: - Nutrition Data Model for the Table
struct NutritionData: Identifiable {
    var id = UUID()
    let ingredient: String
    let totalWeight: Double
    let calories: Double
}
