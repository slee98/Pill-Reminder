//
//  DataController.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/9/23.
//

import CoreData
import Foundation

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
    
    func fetchPills() -> [Pill] {
        let fetchRequest: NSFetchRequest<Pill> = Pill.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Pill.startDate, ascending: false)]
        do {
            let pills = try container.viewContext.fetch(fetchRequest)
            return pills
        } catch {
            print("Failed to fetch pills: \(error)")
            return []
        }
    }
    
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
        scheduleNotification(for: pill)
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
        removeNotifications(for: pill)
        scheduleNotification(for: pill)
    }
    
    func deletePill(pill: Pill) {
        container.viewContext.delete(pill)
        save()
        
        removeNotifications(for: pill)
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
    
    private func removeNotifications(for pill: Pill) {
        guard let pillID = pill.id else {
            return
        }
        if let frequencies = pill.whenToTakeFrequencies?.compactMap({ Weekday(rawValue: $0) }), !frequencies.isEmpty {
            var identifiers = [String]()
            for dayOfWeek in frequencies {
                identifiers.append(pillID.uuidString + dayOfWeek.rawValue)
            }
            NotificationManager.shared.removeNotification(withIDs: identifiers)
        } else {
            NotificationManager.shared.removeNotification(withIDs: [pillID.uuidString])
        }
    }
    
    private func scheduleNotification(for pill: Pill) {
        let title = "It's Time To Take \(pill.name ?? "a pill")!"
        let whenToTakeDate = DateHelper().getWhenToTakeDate(from: pill.whenToTakeTimestamp)
        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: whenToTakeDate)
        
        if let frequencies = pill.whenToTakeFrequencies?.compactMap({ Weekday(rawValue: $0) }), !frequencies.isEmpty {
            for dayOfWeek in frequencies {
                dateComponents.weekday = dayOfWeek.weekdayValue
                NotificationManager.shared.registerNotification(withTitle: title, 
                                                                for: dateComponents,
                                                                identifier: pill.id.map { $0.uuidString + dayOfWeek.rawValue },
                                                                repeat: true)
            }
        } else {
            NotificationManager.shared.registerNotification(withTitle: title,
                                                            for: dateComponents,
                                                            identifier: pill.id?.uuidString,
                                                            repeat: true)
        }
    }
}





