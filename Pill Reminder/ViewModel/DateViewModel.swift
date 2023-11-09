//
//  DateViewModel.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/10/23.
//

import Foundation

class DateViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published var currentWeek: [Date] = []
    @Published var currentDay: Date = Date()
    
    // MARK: Constructor
    
    init() {
        fetchCurrentWeek()
    }
    
    // MARK: Functions
    
    func fetchCurrentWeek() {
        let today = Date()
        let calendar = Calendar.current
        
        guard let week = calendar.dateInterval(of: .weekOfMonth, for: today)?.start else {
            return
        }
        currentWeek = (0..<7).map { calendar.date(byAdding: .day, value: $0, to: week)! }
    }
    
    func formatDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
    
    func getDateMonth(date: Date) -> String {
        return formatDate(date: date, format: "MMM")
    }
    
    func getDate(date: Date) -> String {
        return formatDate(date: date, format: "dd")
    }
    
    func getHourMinutes(date: Date) -> String {
        return formatDate(date: date, format: "h:mm a")
    }
    
    func isToday(date: Date) -> Bool {
        return Calendar.current.isDate(currentDay, inSameDayAs: date)
    }
    
    func getGreetingHeadline(for date: Date) -> String {
        let hour = Calendar.current.component(.hour, from: date)
        
        switch hour {
        case 6...11: return "Morning"
        case 12...17: return "Afternoon"
        default: return "Evening"
        }
    }
}

