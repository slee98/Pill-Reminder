//
//  DateHelper.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/10/23.
//

import Foundation

class DateHelper {
    
    var currentWeek: [Date] = []
    let currentDay: Date = Date()
    
    // Intialize the DataViewModel and fetch the current week
    init() {
        getDayOfWeek()
    }
        
    func getDayOfWeek() {
        let today = Date()
        
        guard let weekInterval = Calendar.current.dateInterval(of: .weekOfMonth, for: today) else {
            fatalError("Unable to get the week of the day")
        }
        currentWeek = (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: weekInterval.start) }
    }
      
    
    func getMonth() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        return formatter.string(from: currentDay)
    }
    
    func getDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: currentDay)
    }
    
    // Format a date to a time string using the provided format
    func getTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: currentDay)
    }
    
    // Determine the time category (Morning, Afternoon, Evening) for a given date
    func getGreetingHeadLine() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        
        if (6...11).contains(hour) {
            return "Morning"
        } else if (12...17).contains(hour) {
            return "Afternoon"
        } else {
            return "Evening"
        }
    }
}
