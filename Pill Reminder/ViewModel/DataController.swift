//
//  DataController.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/9/23.
//

import Foundation
import CoreData


class DataController: ObservableObject {
    
    static let shared = DataController()
    let container = NSPersistentContainer(name: "PillModel")
    
    init() {
        container.loadPersistentStores{ desc, error in
            if let error = error {
                print("failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    // Save changes to the Core Data context
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data Saved")
        } catch {
            print("Date Not Saved")
        }
    }
    
    // Create and add a new Pill entity to Core Data
    func addPill(name: String, dosage: Double, unit: String, time: Date, foodTime: String, frequncy: [Date], context: NSManagedObjectContext) {
        let pill = Pill(context: context)
        pill.id = UUID()
        pill.date = Date()
        pill.name = name
        pill.dosage = dosage
        pill.unit = unit
        pill.foodTime = foodTime
        pill.frequency = frequncy
        
        save(context: context)
    }
    
    // Edit an existing Pill entity in Core Data
    func editPill(pill: Pill, name: String, dosage: Double, unit: String, time: Date, foodTime: String, frequncy: [Date], context: NSManagedObjectContext) {
        pill.date = Date()
        pill.name = name
        pill.dosage = dosage
        pill.unit = unit
        pill.foodTime = foodTime
        pill.frequency = frequncy
        
        save(context: context)
    }
}





