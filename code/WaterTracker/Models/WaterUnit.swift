// filepath: /Users/pierce/Documents/vibe-coding-template/code/WaterTracker/Models/WaterUnit.swift
//
//  WaterUnit.swift
//  WaterTracker
//
//  Created for HydroTracker project.
//
import Foundation

/// Represents the unit of measurement for water consumption
/// Used throughout the app to maintain consistency in measurement units
enum WaterUnit: String, CaseIterable, Identifiable, Codable {
    case milliliters = "ml"
    case fluidOunces = "oz"
    
    var id: String { self.rawValue }
    
    /// Returns the localized display name for the unit
    var localizedName: String {
        switch self {
        case .milliliters:
            return NSLocalizedString("milliliters", comment: "Unit of measurement")
        case .fluidOunces:
            return NSLocalizedString("fluid ounces", comment: "Unit of measurement")
        }
    }
    
    /// Returns the localized abbreviation for the unit
    var localizedAbbreviation: String {
        switch self {
        case .milliliters:
            return NSLocalizedString("ml", comment: "Abbreviation for milliliters")
        case .fluidOunces:
            return NSLocalizedString("oz", comment: "Abbreviation for fluid ounces")
        }
    }
    
    /// Converts a value from this unit to another unit
    /// - Parameters:
    ///   - amount: The amount to convert
    ///   - targetUnit: The unit to convert to
    /// - Returns: The converted amount
    func convert(amount: Double, to targetUnit: WaterUnit) -> Double {
        guard self != targetUnit else { return amount }
        
        switch (self, targetUnit) {
        case (.milliliters, .fluidOunces):
            return amount / 29.574 // ml to oz
        case (.fluidOunces, .milliliters):
            return amount * 29.574 // oz to ml
        default:
            return amount
        }
    }
}