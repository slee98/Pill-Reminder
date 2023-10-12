//
//  EditPillView.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/9/23.
//

import SwiftUI

struct EditPillView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.dismiss) var dismiss // Back to the navigation view
    
    @StateObject var dateViewModel: DateViewModel = DateViewModel()
    @State private var currentDay: Date = Date()
    @State private var name = ""
    @State private var dosage: Double = 200
    @State private var unit: String = "mg"
    @State private var time: Date = Date()
    @State private var foodTime: String = ""
    @State private var isBeforeEatingFoodSelected = false
    @State private var isAfterEatingFoodSelected = false
    @State private var isDataSaved = false
    @State private var isDateDeleted = false
    @State private var frequency: [Date] = []
    
  
    var savedPill: FetchedResults<Pill>.Element
    init(savedPill: Pill) {
        self.savedPill = savedPill
        // Assign the savedPill's dosage to the @State property
        _dosage = State(initialValue: savedPill.dosage)
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute], from: savedPill.date ?? Date())
        let newDate = calendar.date(bySettingHour: dateComponents.hour ?? 0, minute: dateComponents.minute ?? 0, second: 0, of: Date())
        
        _time = State(initialValue: newDate ?? Date())
    }
    
    var body: some View {
        
        VStack {
            Text("Edit Medication")
                .bold()
                .foregroundColor(.black.opacity(0.5))
                .padding(.top,20)
                .padding(.bottom,5)
            
            Form {
                Section(header: Text("Pill Name")
                    .padding(.leading, -17)
                    .foregroundColor(.gray.opacity(0.5))
                    .bold()) {
                        ZStack(alignment: .leading) {
                            Image(systemName: "pills")
                                .foregroundColor(.gray)
                            TextField("\(savedPill.name!)", text: $name)
                                .padding(.leading, 60)
                        }
                    }

                Section(header: Text("Dosage")
                    .padding(.leading, -17)
                    .foregroundColor(.gray.opacity(0.5))
                    .bold()) {
                        ZStack {
                            HStack {
                                Image(systemName: "syringe")
                                    .foregroundColor(.gray)
                                HStack(spacing: 2) {
                                    TextField("Int(\(savedPill.dosage)))", value: $dosage, format: .number)
                                        .padding(.leading, 100)
                                    
                                    TextField("\(savedPill.unit!))", text: $unit)
                                        .padding(.leading, 100)
                                }
                            }
                        }
                    }
                
                Section(header: Text("Food")
                    .padding(.leading, -17)
                    .foregroundColor(.gray.opacity(0.5))
                    .bold()) {
                        VStack {
                            Image(systemName: "fork.knife")
                                .foregroundColor(.gray)
                                .padding(.leading, 5)
                            HStack(spacing: 20) {
                                Text("Before Eating Food")
                                    .font(.system(size: 14))
                                    .frame(width: 150, height: 80)
                                    .background(savedPill.foodTime == "Before Eating Food" ? .blue.opacity(0.15) : .gray.opacity(0.1))
                                    .onTapGesture {
                                        isBeforeEatingFoodSelected.toggle()
                                        foodTime = "Before Eating Food"
                                    }
                                    .cornerRadius(10)
                                    .padding(.leading, 10)
                                    .padding(.top, 20)
                                    .padding(.bottom, 20)
                                
                                Text("After Eating Food")
                                    .font(.system(size: 14))
                                    .frame(width: 150, height: 80)
                                    .background(savedPill.foodTime == "After Eating Food" ? .blue.opacity(0.15) : .gray.opacity(0.1))
                                    .onTapGesture {
                                        isAfterEatingFoodSelected.toggle()
                                        foodTime = "After Eating Food"
                                    }
                                    .cornerRadius(10)
                                    .padding(.trailing, 10)
                                    .padding(.top, 20)
                                    .padding(.bottom, 20)
                            }
                        }
                    }
                
                Section(header: Text("Notification")
                    .padding(.leading, -17)
                    .foregroundColor(.gray.opacity(0.5))
                    .bold()) {
                        ZStack(alignment: .leading) {
                            VStack {
                                HStack {
                                    Image(systemName: "clock")
                                        .foregroundColor(.gray)
                                        .padding(.leading, 5)
                                    Text("Time")
                                    
                                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                        .datePickerStyle(.graphical)
                                }
                                
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 10) {
                                        ForEach(dateViewModel.currentWeek, id: \.self) { day in
                                            
                                            ZStack {
                                                Circle()
                                                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                                    .fill(savedPill.frequency!.contains(day) ? Color.blue.opacity(0.15) : Color.white)
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
                                        }
                                    }
                                }
                            }
                        }
                    }
                    // Section for saving a pill
                    Section() {
                        Button("Submit") {
                            DataController().save(context: viewContext) // Save the data
                            isDataSaved = true // Set a flag to display an alert
                            // Reset form values (This part may need clarification)
                            name = name
                            dosage = dosage
                            unit = unit
                            time = time
                            foodTime = foodTime
                            frequency = frequency
                        }
                        .frame(maxWidth: .infinity) // Center-align the button text
                        .alert(isPresented: $isDataSaved) {
                            Alert(
                                title: Text(""),
                                message: Text("Your medicine has been successfully saved."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                    }
                    
                    // Section for deleting a pill
                    Section() {
                        Button("Delete") {
                            deletePill(pill: savedPill) // Call the deletePill function
                            isDateDeleted = true // Set a flag to display an alert
                            dismiss()
                        }
                        .frame(maxWidth: .infinity) // Center-align the button text
                        .foregroundColor(.red)
                        .alert(isPresented: $isDateDeleted) {
                            Alert(
                                title: Text("Pill Deleted"),
                                message: Text("Your medicine has been successfully deleted."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                }
            }
            .foregroundColor(.black)
            .tint(.blue)
            .background(
                LinearGradient(gradient: Gradient(colors: [
                    Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)),
                    Color(#colorLiteral(red: 0.2666666667, green: 0.6705882353, blue: 1, alpha: 0.7517111971)),
                    Color(#colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1))
                ]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            )
        }
      
         
    }
    func deletePill(pill: Pill) {
        withAnimation {
            viewContext.delete(pill)
        }
    }
}

struct EditPillView_Previews: PreviewProvider {
    static var previews: some View {
        EditPillView(savedPill: Pill())
    }
}

