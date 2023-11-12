//
//  DataController.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/9/23.
//

import Foundation
import CoreData

class PillsDataManager: ObservableObject {
    
    static let shared = PillsDataManager()
    
    
    let container = NSPersistentContainer(name: "Pill")
    
    private init() {
        container.loadPersistentStores{ desc, error in
            if let error = error {
                print("failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: - Public Methods
    
    // Create and add a new Pill entity to Core Data
    func addPill(name: String, dosage: String, unit: String, whenToTake: TimeInterval, frequencies: [Weekday]) {
        let pill = Pill(context: container.viewContext)
        pill.id = UUID()
        pill.startDate = Date()
        pill.name = name
        pill.dosage = dosage
        pill.unit = unit
        pill.whenToTakeTimestamp = whenToTake
        pill.whenToTakeFrequencies = frequencies.map { $0.rawValue }
        
        save()
    }
    
    // Edit an existing Pill entity in Core Data
    func editPill(pill: Pill, name: String, dosage: String, unit: String, whenToTake: TimeInterval, frequencies: [Weekday]) {
        pill.startDate = Date()
        pill.name = name
        pill.dosage = dosage
        pill.unit = unit
        pill.whenToTakeTimestamp = whenToTake
        pill.whenToTakeFrequencies = frequencies.map { $0.rawValue }
        
        save()
    }
    
    func deletePill(pill: Pill) {
        container.viewContext.delete(pill)
        save()
    }
    
    // MARK: - Private Methods
    
    // Save changes to the Core Data context
    private func save() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Date Not Saved. Error: \(error)")
        }
    }
}





