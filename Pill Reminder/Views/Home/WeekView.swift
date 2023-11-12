//
//  WeekView.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 11/9/23.
//

import SwiftUI

struct WeekView: View {
    
    let dateViewModel = DateHelper()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(dateViewModel.currentWeek, id: \.self) { date in
                    ZStack {
                        Circle()
                            .fill(Calendar.current.isDate(dateViewModel.currentDay, inSameDayAs: date)
                                   ? Color.blue.opacity(0.5) : Color.white)
                            .frame(width: 42, height: 42)
                        VStack {
                            Text(dateViewModel.getDayOfWeek(for: date))
                                .font(.system(size: 12))
                                .bold()
                            
                            Text(dateViewModel.getDayOfMonth(for: date))
                                .font(.system(size: 12))
                        }
                    }
                }
            }
            .padding(.leading)
        }
    }
}
#Preview {
    WeekView()
}
