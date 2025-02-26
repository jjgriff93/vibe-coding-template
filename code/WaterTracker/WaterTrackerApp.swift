//
//  WaterTrackerApp.swift
//  WaterTracker
//
//  Created for HydroTracker project.
//

import SwiftUI

@main
struct WaterTrackerApp: App {
    // Initialize the persistence controller
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
