//
//  Pill_ReminderApp.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/9/23.
//

import SwiftUI

@main
struct Pill_ReminderApp: App {
    
    //Create a DataController instance to manage Core Data
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
