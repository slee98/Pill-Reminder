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
    
    
    var body: some View {
        // Add the TabView at the bottom
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)),Color(#colorLiteral(red: 0.2666666667, green: 0.6705882353, blue: 1, alpha: 0.7517111971)), Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))]),
                           startPoint: .top,
                           endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            VStack {
                switch selectedTab {
                    case .house:
                        ContentView()
                    case .pill:
                    PillDetailView {
                        selectedTab = .house
                    }
                    case .calendar:
                        CalendarView()
                }
                
                Spacer()
                
                TabView(selectedTab: $selectedTab)
            }
        }
    }
}

#Preview {
    MainView()
}
