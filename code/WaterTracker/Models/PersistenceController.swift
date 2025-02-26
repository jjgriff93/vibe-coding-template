// filepath: /Users/pierce/Documents/vibe-coding-template/code/WaterTracker/Models/PersistenceController.swift
//
//  PersistenceController.swift
//  WaterTracker
//
//  Created for HydroTracker project.
//
import CoreData
import Foundation

/// Manages the Core Data stack for the application
struct PersistenceController {
    /// Shared instance for app-wide use
    static let shared = PersistenceController()
    
    /// Preview instance for SwiftUI previews
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        // Create a sample entry for preview
        let entry = WaterConsumptionEntry(context: viewContext)
        entry.id = UUID()
        entry.date = Date()
        entry.amount = 750
        entry.unitRaw = WaterUnit.milliliters.rawValue
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return controller
    }()
    
    let container: NSPersistentContainer
    
    /// Initialize the persistence controller
    /// - Parameter inMemory: If true, uses in-memory store (for previews and testing)
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "WaterTracker")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Handle errors appropriately in a shipping application
                // For now, we'll just log the error and continue
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}

// MARK: - WaterConsumptionEntry Extensions
extension WaterConsumptionEntry {
    /// The water unit for this entry
    var unit: WaterUnit {
        get {
            return WaterUnit(rawValue: unitRaw ?? "ml") ?? .milliliters
        }
        set {
            unitRaw = newValue.rawValue
        }
    }
    
    /// Format the amount with the appropriate unit for display
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 1
        
        guard let formattedNumber = formatter.string(from: NSNumber(value: amount)) else {
            return "\(Int(amount)) \(unit.localizedAbbreviation)"
        }
        
        return "\(formattedNumber) \(unit.localizedAbbreviation)"
    }
}