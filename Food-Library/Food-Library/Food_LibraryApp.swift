//
//  Food_LibraryApp.swift
//  Food-Library
//
//  Created by apple on 4.11.24.
//

import SwiftUI
import Firebase
@main
struct FoodLibraryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            FisrtScreen()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
