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
    
    @ObservedObject var dateViewModel = DateViewModel()
    @State private var isSheetPresented = false
    @StateObject var pillViewModel = PillFilterViewModel()
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)),Color(#colorLiteral(red: 0.2666666667, green: 0.6705882353, blue: 1, alpha: 0.7517111971)), Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    GreetingHeadLineView()
                    Text(Date().formatted(date: .complete, time: .omitted))
                        .bold()
                        .textScale(.secondary)
                        .foregroundStyle(.white)
                        .padding(.top, 30)
                    
                    WeekView()
                    
                    PillInfoView()
                        .padding(.top, 270)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}




