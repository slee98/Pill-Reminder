//
//  MainView.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/10/23.
//

import CoreData
import SwiftUI

struct MainView: View {
    
    @State private var selectedTab: Tab = .house
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        // Add the TabView at the bottom
        ZStack {
            switch selectedTab {
            case .house:
                ContentView()
            //case .pills:
                //AddPillView()
            case .calendar:
                CalendarView()
            }
            
            Spacer()
            
            TabView(selectedTab: $selectedTab, pill: Pill())
                .padding(.top, 650)
            
        }
    }
}

#Preview {
    MainView()
}
