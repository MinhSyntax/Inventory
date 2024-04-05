//
//  InventoryApp.swift
//  Inventory
//
//  Created by Man Minni on 05.04.24.
//

import SwiftUI

@main
struct InventoryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
