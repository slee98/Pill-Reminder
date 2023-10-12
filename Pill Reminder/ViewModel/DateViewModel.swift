//
//  DateViewModel.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/10/23.
//

import Foundation

class DateViewModel: ObservableObject {
    
    // Intialize the DataViewModel and fetch the current week
    init() {
        fetchCurrentWeek()
    }
    
    // Current Week Days
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    
    // Fetch the dates for the current week
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        // Calculate the date interval for the current week
        let week = calendar.dateInterval(of: .weekOfMonth, for: today)
        
        guard let firstWeekDay = week?.start else {
            return
        }
        // Populate currentWeek with dates for the entire week
        (1...7).forEach { day in
            if let weekday = calendar.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }
    
    // Format a date to a string using the provided format
    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    // Check if a given date is today
    func isToday(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(currentDay, inSameDayAs: date)
    }
    
    // Determine the time category (Morning, Afternoon, Evening) for a given date
    func getTimeCategory(for date: Date) -> String {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        
        if (6...11).contains(hour) {
            return "Morning"
        } else if (12...17).contains(hour) {
            return "Afternoon"
        } else {
            return "Evening"
        }
    }
}

