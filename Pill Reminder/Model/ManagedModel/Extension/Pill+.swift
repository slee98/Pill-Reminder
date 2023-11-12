//
//  Pill+.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 11/11/23.
//

import Foundation

extension Pill {
    
    var dosageUnitString: String {
        let dosage = self.dosage ?? "<N/A>"
        let unit = self.unit ?? "mg"
        return "\(dosage) \(unit)"
    }
}
