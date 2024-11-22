//
//  Food_LibraryApp.swift
//  Food-Library
//
//  Created by apple on 4.11.24.
//

import SwiftUI
import FirebaseCore
@main
struct FoodLibraryApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            FisrtScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
