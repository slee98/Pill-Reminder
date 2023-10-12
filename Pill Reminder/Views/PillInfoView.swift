//
//  PillInfoView.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/11/23.
//

import SwiftUI

struct PillInfoView: View {
    
    @State private var selectedPill: Pill?
    let gridColumns = [GridItem(.fixed(100),spacing: 80),GridItem(.fixed(100),spacing: 80)]
    @State private var isSheetPresented = false // Create a state variable to control the sheet presentation
    @FetchRequest(entity: Pill.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Pill.date, ascending: false)]) var pills: FetchedResults<Pill>
    @StateObject var pillViewModel = PillFilterViewModel() // Create an instance of the view model
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var dateViewModel: DateViewModel = DateViewModel()
    
    
    var body: some View {
        ScrollView {
            
            LazyVGrid(columns: gridColumns) {
                
                ForEach(pills) { pill in
                    
                    Button(action: {
                        selectedPill = pill
                        isSheetPresented.toggle() // Toggle the state to show/hide the sheet
                    }) {
                        
                        ZStack {
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: 160, height: 90)
                                .cornerRadius(30)
                                .shadow(color: .gray, radius: 5)
                            
                            
                            VStack {
                                Text(pill.name ?? "<no name>")
                                    .bold()
                                    .font(.system(size: 14))
                                Text("Dosage: \(Int(pill.dosage))")
                                    .font(.system(size: 12))
                                
                                Text("Time: \(dateViewModel.extractDate(date: pill.date ?? Date(), format: "HH:mm"))")
                                    .font(.system(size: 12))
                                
                                Text("\(formatDates(pill.frequency!))")
                                    .font(.system(size: 12))
                                
                            }
                        }
                        
                    }
                    .sheet(item: $selectedPill) { selectedPill in
                        EditPillView(savedPill: selectedPill)
                        
                    }
                    
                }
                .foregroundColor(.black)
                .padding(.top, 20)
                
            }
        }
        
    }
    
    // Format an array of Date values into a readable string
    private func formatDates(_ dates: [Date]) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // Customize the date format as needed
        
        let formattedDates = dates.map { dateFormatter.string(from: $0) }
        return formattedDates.joined(separator: ", ")
    }
    private func deletePill(pill: Pill) {
        withAnimation {
            viewContext.delete(pill)
        }
    }
}



#Preview {
    PillInfoView()
}
