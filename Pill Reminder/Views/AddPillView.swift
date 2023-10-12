//
//  AddPillView.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/10/23.
//

import SwiftUI

struct AddPillView: View {
    
    
    @Environment (\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    //Date=related properties
    @StateObject var dateViewModel: DateViewModel = DateViewModel()
    @State private var currentDay : Date = Date()
    
    //Medication Properties
    @State private var name = ""
    @State private var dosage: Double = 200
    @State private var unit: String = "mg"
    @State private var time: Date = Date()
    @State private var foodTime: String = ""
    @State private var isBeforeEatingFoodSelected = false
    @State private var isAfterEatingFoodSelected = false
    @State private var isDataSaved = false
    @State private var frequency: [Date] = []
    
    
    var body: some View {
        
        VStack {
            Form {
                
                Section(header: Text("Pills Name")
                    .padding(.leading, -17)
                    .foregroundColor(.white)
                    .bold()
                ) {
                    
                    ZStack(alignment: .leading) {
                        Image(systemName: "pills")
                            .foregroundColor(.gray)
                        TextField("", text: $name)
                            .padding(.leading, 60)
                    }
                }
                
                Section(header: Text("Dosage")
                    .padding(.leading, -17)
                    .foregroundColor(.white)
                    .bold()) {
                        
                        ZStack {
                            HStack {
                                Image(systemName: "syringe")
                                    .foregroundColor(.gray) // Adjust color as needed
                                HStack(spacing: 2){
                                    TextField("", value: $dosage, format: .number)
                                        .padding(.leading, 100)
                                    
                                    TextField("", text: $unit)
                                        .padding(.leading, 100)
                                    
                                }
                            }
                        }
                    }
                Section(header: Text("Food")
                    .padding(.leading, -17)
                    .foregroundColor(.white)
                    .bold()) {
                        VStack {
                            Image(systemName: "fork.knife")
                                .foregroundColor(.gray) // Adjust color as needed
                                .padding(.leading, 5)
                            HStack(spacing: 20) {
                                
                                Text("Before Eating Food")
                                    .font(.system(size: 14))
                                    .frame(width: 150, height: 80)
                                    .background(isBeforeEatingFoodSelected ? .blue.opacity(0.15) : .gray.opacity(0.1))
                                
                                    .onTapGesture {
                                        isBeforeEatingFoodSelected.toggle()
                                        foodTime = "Before Eating Food"
                                        
                                    }
                                    .cornerRadius(10)
                                    .padding(.leading, 10)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                                
                                
                                Text("After Eating Food")
                                    .font(.system(size: 14))
                                    .frame(width: 150, height: 80)
                                    .background(isAfterEatingFoodSelected ? .blue.opacity(0.15) : .gray.opacity(0.1))
                                
                                    .onTapGesture {
                                        isAfterEatingFoodSelected.toggle()
                                        foodTime = "After Eating Food"
                                    }
                                    .cornerRadius(10)
                                    .padding(.trailing, 10)
                                    .padding(.top, 5)
                                    .padding(.bottom, 5)
                            }
                            
                        }
                    }
                Section(header: Text("Notification")
                    .padding(.leading, -17)
                    .foregroundColor(.white)
                    .bold()) {
                        ZStack(alignment: .leading) {
                            VStack {
                                HStack {
                                    Image(systemName: "clock")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 5)
                                    Text("Time")
                                    
                                    DatePicker("Select a Time", selection: $time, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                        .datePickerStyle(.graphical)
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(dateViewModel.currentWeek, id:\.self) { day in
                                            ZStack {
                                                Circle()
                                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                                    .fill(frequency.contains(day) ? Color.blue.opacity(0.15) : Color.white) // Fill color
                                                    .frame(width: 43, height: 43)
                                                
                                                HStack {
                                                    Text(dateViewModel.extractDate(date: day, format: "EEE"))
                                                        .font(.system(size: 12))
                                                        .bold()
                                                }
                                                .onTapGesture {
                                                    // Toggle the selection of the day
                                                    withAnimation {
                                                        if let index = frequency.firstIndex(of: day) {
                                                            frequency.remove(at: index)
                                                        } else {
                                                            frequency.append(day)
                                                        }
                                                    }
                                                }
                                            }
                                            .padding(.bottom, 10)
                                        }
                                    }
                                }
                            }
                        }
                    }
                HStack {
                    Spacer()
                    Button("Submit") {
                        DataController().addPill(name: name, dosage: dosage, unit: unit, time: time, foodTime: foodTime, frequncy: frequency, context: managedObjectContext)
                        isDataSaved = true
                        // Reset the form values
                        
                    }
                    .frame(maxWidth: .infinity) // Center-align the button text
                    .alert(isPresented: $isDataSaved) {
                        Alert(
                            title: Text("Pill Saved"),
                            message: Text("Your medicine has been successfully saved."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
            }
            .foregroundColor(.gray)
            .tint(.blue)
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)),Color(#colorLiteral(red: 0.2666666667, green: 0.6705882353, blue: 1, alpha: 0.7517111971)), Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
            )            .scrollContentBackground(.hidden)
        }
       
    }
}

#Preview {
    AddPillView()
}
