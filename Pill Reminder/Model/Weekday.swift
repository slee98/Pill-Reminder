//
//  Weekday.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 11/11/23.
//

import Foundation

public enum Weekday: String {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
    
    static func from(date: Date) -> Weekday {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date)
        
        switch components.weekday {
        case 1: return .sunday
        case 2: return .monday
        case 3: return .tuesday
        case 4: return .wednesday
        case 5: return .thursday
        case 6: return .friday
        case 7: return .saturday
        default:
            fatalError("Should never happen. Tested all cases!")
        }
    }
    
    var weekdayValue: Int {
        switch self {
        case .sunday: return 1
        case .monday: return 2
        case .tuesday: return 3
        case .wednesday: return 4
        case .thursday: return 5
        case .friday: return 6
        case .saturday: return 7
        }
    }
    
    var shortString: String {
        switch self {
        case .monday: return "Mon"
        case .tuesday: return "Tue"
        case .wednesday: return "Wed"
        case .thursday: return "Thur"
        case .friday: return "Fri"
        case .saturday: return "Sat"
        case .sunday: return "Sun"
        }
    }
}
