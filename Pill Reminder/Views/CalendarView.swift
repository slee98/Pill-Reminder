//
//  CalendarView.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/10/23.
//

import SwiftUI

struct CalendarView: View {
    
    @State var date : Date = Date()
    @State private var drugNames: [String] = []
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)),Color(#colorLiteral(red: 0.2666666667, green: 0.6705882353, blue: 1, alpha: 0.7517111971)), Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            DatePicker(
                "Start Date",
                selection: $date,
                displayedComponents: [.date]
            )
            .padding()
            .datePickerStyle(.graphical)
        }
    }
}

#Preview {
    CalendarView()
}
