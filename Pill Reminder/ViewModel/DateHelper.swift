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
    
    init() {
        populateCurrentWeek()
    }
    
    func populateCurrentWeek() {
        let today = Date()
        
        guard let weekInterval = Calendar.current.dateInterval(of: .weekOfMonth, for: today) else {
            fatalError("Unable to get the week of the day")
        }
        currentWeek = (0..<7).compactMap { Calendar.current.date(byAdding: .day, value: $0, to: weekInterval.start) }
    }
    
    func getDayOfWeek(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    func getDayOfMonth(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
    
    func getTime(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
    
    func getTime(fromWhenToTakeTimestamp whenToTakeTimestamp: TimeInterval) -> String {
        let whenToTakeTime = beginningOfDay().addingTimeInterval(whenToTakeTimestamp)
        return getTime(for: whenToTakeTime)
    }
    
    func getWhenToTakeDate(from timeInterval: TimeInterval) -> Date {
        return beginningOfDay().addingTimeInterval(timeInterval)
    }
    
    func getWhenToTakeTimeInverval(from date: Date = Date()) -> TimeInterval {
        return date.timeIntervalSince(beginningOfDay())
    }
    
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
    
    // MARK: - Private Methods
    
    private func beginningOfDay() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: Date())
        let beginningOfDay = calendar.date(from: components)!
        
        return beginningOfDay
    }
}
