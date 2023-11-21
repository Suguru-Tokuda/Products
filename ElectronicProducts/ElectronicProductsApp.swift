//
//  ElectronicProductsApp.swift
//  ElectronicProducts
//
//  Created by Suguru Tokuda on 11/21/23.
//

import SwiftUI

@main
struct ElectronicProductsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
