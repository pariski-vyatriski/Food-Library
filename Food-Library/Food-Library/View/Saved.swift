//
//  ContentView.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.
//

import SwiftUI
import CoreData

struct Saved: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        entity: Scales.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Scales.name, ascending: true)
        ]
    ) var scales: FetchedResults<Scales>
    @State private var isAlertModalPresent = false
    @State private var scalesNameInput = ""
    @State private var scalesValueInput = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(scales, id: \.self) { scales in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(scales.name ?? "Nill Scales")
                            .headers()
                        Text(scales.value ?? "Nill Scales")
                            .textFieldModifier()

                    }
                }
                .onDelete(perform: deleteScales)
            }
            .navigationTitle("Scales")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isAlertModalPresent.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundColor(.color)
                    })
                }
            }
            .alert("Add Scales", isPresented: $isAlertModalPresent) {
                TextField("Type of product", text: $scalesNameInput)
                TextField("Enter the value", text: $scalesValueInput)
                Button("OK", action: addScales)
                Button("Cancel", role: .cancel, action: cleanupInputs)
            }
        }
    }
    func addScales() {
        let newScales = Scales(context: self.moc)
        newScales.name = scalesNameInput
        newScales.value = scalesValueInput

        do {
            try self.moc.save()
        } catch {
            print(error.localizedDescription)
        }
        cleanupInputs()
    }
    func deleteScales(at offsets: IndexSet) {
        for index in offsets {
            let scales = scales[index]
            moc.delete(scales)
        }
        do {
            try moc.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    private func cleanupInputs() {
        scalesNameInput = ""
        scalesValueInput = ""
    }
}

struct Saved_Previews: PreviewProvider {
    static let persistenseController = PersistenceController.shared

    static var previews: some View {
        Saved()
            .environment(\.managedObjectContext, persistenseController.container.viewContext)
    }
}
