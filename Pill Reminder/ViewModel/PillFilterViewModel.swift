//
//  PillFilterViewModel.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/11/23.
//

import Foundation
import CoreData

class PillFilterViewModel: ObservableObject {
    @Published var selectedDay: String
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        self.selectedDay = dateFormatter.string(from: Date())
    }
}
