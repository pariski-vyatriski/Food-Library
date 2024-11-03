//
//  Food_LibraryApp.swift
//  Food-Library
//
//  Created by apple on 4.11.24.
//

import SwiftUI

@main
struct Food_LibraryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
