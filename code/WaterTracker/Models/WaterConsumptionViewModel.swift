// filepath: /Users/pierce/Documents/vibe-coding-template/code/WaterTracker/Models/WaterConsumptionViewModel.swift
//
//  WaterConsumptionViewModel.swift
//  WaterTracker
//
//  Created for HydroTracker project.
//
import Foundation
import CoreData
import SwiftUI

/// ViewModel that manages water consumption data and business logic
class WaterConsumptionViewModel: ObservableObject {
    /// Current water consumption entry for today
    @Published private(set) var todayEntry: WaterConsumptionEntry?
    
    /// The default water unit used in the app
    @Published var preferredUnit: WaterUnit = .milliliters {
        didSet {
            UserDefaults.standard.set(preferredUnit.rawValue, forKey: "preferredWaterUnit")
        }
    }
    
    /// Preset amounts for quick adding water
    @Published var presetAmounts: [Double] = [100, 250, 500, 750]
    
    /// Reference to the view context for CoreData operations
    private let viewContext: NSManagedObjectContext
    
    /// Initialize the view model
    /// - Parameter viewContext: The managed object context to use
    init(viewContext: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = viewContext
        
        // Load user's preferred unit from UserDefaults
        if let savedUnitRaw = UserDefaults.standard.string(forKey: "preferredWaterUnit"),
           let savedUnit = WaterUnit(rawValue: savedUnitRaw) {
            self.preferredUnit = savedUnit
        }
        
        // Initial fetch of today's entry
        fetchOrCreateTodayEntry()
    }
    
    /// Fetch today's entry or create one if it doesn't exist
    func fetchOrCreateTodayEntry() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!
        
        let fetchRequest: NSFetchRequest<WaterConsumptionEntry> = WaterConsumptionEntry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", today as NSDate, tomorrow as NSDate)
        
        do {
            let entries = try viewContext.fetch(fetchRequest)
            if let existingEntry = entries.first {
                todayEntry = existingEntry
            } else {
                // Create a new entry for today
                let newEntry = WaterConsumptionEntry(context: viewContext)
                newEntry.id = UUID()
                newEntry.date = today
                newEntry.amount = 0
                newEntry.unit = preferredUnit
                
                try viewContext.save()
                todayEntry = newEntry
            }
        } catch {
            print("Error fetching or creating today's entry: \(error)")
        }
    }
    
    /// Add water to today's consumption
    /// - Parameter amount: The amount of water to add
    func addWater(_ amount: Double) {
        guard let entry = todayEntry else {
            fetchOrCreateTodayEntry()
            return
        }
        
        entry.amount += amount
        saveContext()
        
        // Provide haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    /// Remove water from today's consumption
    /// - Parameter amount: The amount of water to remove
    /// - Returns: True if the amount was removed, false if it would result in negative total
    func removeWater(_ amount: Double) -> Bool {
        guard let entry = todayEntry else {
            fetchOrCreateTodayEntry()
            return false
        }
        
        // Don't allow negative amounts
        if entry.amount - amount < 0 {
            // Provide error feedback
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            return false
        }
        
        entry.amount -= amount
        saveContext()
        
        // Provide haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        return true
    }
    
    /// Update water amount with a custom value
    /// - Parameters:
    ///   - amount: The amount to change by
    ///   - isAddition: Whether to add or remove the amount
    /// - Returns: True if the operation was successful
    func updateWater(amount: Double, isAddition: Bool) -> Bool {
        if isAddition {
            addWater(amount)
            return true
        } else {
            return removeWater(amount)
        }
    }
    
    /// Save the current context
    private func saveContext() {
        do {
            try viewContext.save()
            objectWillChange.send()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}