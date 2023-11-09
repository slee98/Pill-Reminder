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
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Pill.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Pill.date, ascending: false)]) var pills: FetchedResults<Pill>
    
    @StateObject var dateViewModel: DateViewModel = DateViewModel()
    @State private var currentDay : Date = Date()
    // Create a state variable to control the sheet presentation
    @State private var isSheetPresented = false
    // Create an instance of the view model
    @StateObject var pillViewModel = PillFilterViewModel()
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)),Color(#colorLiteral(red: 0.2666666667, green: 0.6705882353, blue: 1, alpha: 0.7517111971)), Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading) {
                    
                    Text("Pill Reminder")
                        .foregroundColor(.white)
                        .padding(.leading, 150)
                        .bold()
                        .padding(.top, 10)
                    
                    HStack {
                        
                        Text("Good \(dateViewModel.getGreetingHeadline(for: currentDay)),")
                            .bold()
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding(.top, 30)
                            .padding(.leading, 30)
                        
                        Image(systemName: "bell.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.white)
                            .padding(.leading, 80)
                            .padding(.bottom, 30)
                    }
                    Text("We will remind you of the mecidines you need to take today")
                        .font(.system(size: 14))
                        .foregroundColor(.white)
                        .padding(.leading, 30)
                    
                    
                    Text(currentDay.formatted(date: .complete, time: .omitted))
                        .bold()
                        .textScale(.secondary)
                        .foregroundStyle(.white)
                        .padding(.leading, 100)
                        .padding(.top, 30)
                    Spacer()
                    
                    //Week Slider
                    ScrollView (.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            
                            ForEach(dateViewModel.currentWeek, id:\.self) { day in
                                ZStack {
                                    
                                    Circle()
                                        .fill(dateViewModel.isToday(date: day) ? Color.blue.opacity(0.5) : Color.white) // Fill color
                                        .frame(width: 43, height: 43)
                                    
                                    VStack {
                                        Text(dateViewModel.extractDate(date: day, format: "EEE"))
                                            .font(.system(size: 12))
                                            .bold()
                                        Text(dateViewModel.extractDate(date: day, format: "dd"))
                                            .font(.system(size: 12))
                                    }
                                    .onTapGesture {
                                        //updating current day
                                        withAnimation{
                                            dateViewModel.currentDay = day
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.leading,20)
                        .padding(.bottom, 500)
                    }
                }
                PillInfoView()
                    .padding(.top, 270)
            }
        }
    }
}

#Preview {
    ContentView()
}




