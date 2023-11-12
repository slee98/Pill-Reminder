//
//  Tab.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/10/23.
//

import Foundation
import SwiftUI

enum Tab: String, CaseIterable {
    case house
    case pill
    case calendar
    
    var image: Image {
        Image(systemName: rawValue)
    }
}
