//
//  ContentView.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/9/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    @FetchRequest(entity: Pill.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Pill.startDate, ascending: false)]) var pills: FetchedResults<Pill>
    
    let dateViewModel = DateHelper()
    @State private var isSheetPresented = false
    
    
    var body: some View {
        VStack {
            GreetingHeadLineView()
                .padding(.top)
            Text(Date().formatted(date: .complete, time: .omitted))
                .bold()
                .textScale(.secondary)
                .foregroundStyle(.white)
                .padding(.top, 30)
            
            WeekView()
            PillInfoCardListView()
                .padding(.top)
        }
    }
}

#Preview {
    ContentView()
}




