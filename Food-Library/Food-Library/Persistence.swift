//
//  Persistence.swift
//  FoodLibrarySwiftUi
//
//  Created by apple on 27.10.24.
//

import CoreData

class PersistenceController: ObservableObject {
  let container = NSPersistentContainer(name: "Scales")

  static let shared = PersistenceController()

    private init() {
        container.loadPersistentStores { _, error in
      if let error = error {
        print("Core Data failed to load: \(error.localizedDescription)")
      }
    }
  }
}
