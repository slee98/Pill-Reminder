//
//  PillDetailView.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/10/23.
//

import SwiftUI

struct PillDetailView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let dateHelper: DateHelper
    private let originalPill: Pill?
    private let onComplete: () -> Void
    
    //Medication Properties
    @State private var name: String
    @State private var dosage: String
    @State private var unit: String
    @State private var time: Date
    @State private var isBeforeEatingFoodSelected = false
    @State private var isAfterEatingFoodSelected = false
    @State private var isDataSaved = false
    @State private var frequencies: Set<Weekday>
    
    init(originalPill: Pill? = nil, onComplete: @escaping () -> Void) {
        let dateHelper = DateHelper()
        self.originalPill = originalPill
        self.dateHelper = dateHelper
        
        _name = State(initialValue: originalPill?.name ?? "")
        _dosage = State(initialValue: originalPill?.dosage ?? "")
        _unit = State(initialValue: originalPill?.unit ?? "")
        _time = State(initialValue: originalPill.map { dateHelper.getWhenToTakeDate(from: $0.whenToTakeTimestamp) } ?? Date())
        _frequencies = State(initialValue: Set(originalPill?.whenToTakeFrequencies?.compactMap { Weekday(rawValue: $0) } ?? []))
        self.onComplete = onComplete
    }
    
    var body: some View {
        Form(content: {
            Section(header: Text("Pill Name")
                .padding(.leading, -15)){
                    ZStack(alignment: .leading) {
                        Image(systemName: "pills")
                            .foregroundColor(.gray)
                        TextField("Pill Name", text: $name)
                            .padding(.leading, 80)
                    }
                }
            
            Section(header: Text("Dosage")
                .padding(.leading, -15)) {
                    ZStack(alignment: .leading) {
                        Image(systemName: "syringe")
                            .foregroundColor(.gray)
                        TextField("Dosage", text: $dosage)
                            .padding(.leading, 80)
                        TextField("mg", text: $unit)
                            .padding(.leading, 280)
                    }
                }
            Section(header: Text("Food")
                .padding(.leading, -15)) {
                    VStack {
                        Image(systemName: "fork.knife")
                            .foregroundColor(.gray)
                        HStack {
                            Text("Before Eating Food")
                                .font(.system(size: 14))
                                .frame(width: 150, height: 80)
                                .background(isBeforeEatingFoodSelected ? .blue.opacity(0.15) : .gray.opacity(0.1))
                                .cornerRadius(10)
                                .onTapGesture {
                                    isBeforeEatingFoodSelected.toggle()
                                }
                            Text("After Eating Food")
                                .font(.system(size: 14))
                                .frame(width: 150, height: 80)
                                .background(isAfterEatingFoodSelected ? .blue.opacity(0.15) : .gray.opacity(0.1))
                                .cornerRadius(10)
                                .onTapGesture {
                                    isAfterEatingFoodSelected.toggle()
                                }
                        }
                    }
                }
            Section(header: Text("Notification")
                .padding(.leading, -15)) {
                    VStack {
                        HStack {
                            Image(systemName: "clock")
                                .foregroundColor(.gray)
                            DatePicker("Select a Time", selection: $time, displayedComponents: .hourAndMinute)
                                .datePickerStyle(.graphical)
                        }
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(dateHelper.currentWeek, id: \.self) { day in
                                    let weekday = Weekday.from(date: day)
                                    ZStack {
                                        Circle()
                                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                            .fill(frequencies.contains(weekday) ? Color.blue.opacity(0.15) : Color.white)
                                            .frame(width:40, height: 40)
                                        Text(weekday.shortString)
                                            .font(.system(size: 12))
                                    }
                                    .onTapGesture {
                                        let weekday = Weekday.from(date: day)
                                        if frequencies.contains(weekday) {
                                            frequencies.remove(weekday)
                                        } else {
                                            frequencies.insert(weekday)
                                        }
                                    }
                                }
                            }
                            .padding(.vertical)
                            .padding(.horizontal, 1)
                        }
                    }
                }
            Section {
                Button("Submit") {
                    let whenToTakeTime = dateHelper.getWhenToTakeTimeInverval(from: time)
                    if let originalPill = originalPill {
                        PillsDataManager.shared.editPill(pill: originalPill, name: name, dosage: dosage, unit: unit, whenToTake: whenToTakeTime, frequencies: Array(frequencies))
                    } else {
                        PillsDataManager.shared.addPill(name: name, dosage: dosage, unit: unit, whenToTake: whenToTakeTime, frequencies: Array(frequencies))
                    }
                    isDataSaved = true
                    resetInputs()
                    onComplete()
                }
                .frame(maxWidth: .infinity)
                if let originalPill = originalPill {
                    Button("Delete") {
                        PillsDataManager.shared.deletePill(pill: originalPill)
                        onComplete()
                    }
                    .foregroundStyle(.red)
                    .frame(maxWidth: .infinity)
                }
            }
        })
        .alert(isPresented: $isDataSaved) {
            Alert(
                title: Text("Pill Saved"),
                message: Text("Your medicine has been successfully saved."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func resetInputs() {
        name = ""
        dosage = "200"
        unit = "mg"
        time = Date()
        isBeforeEatingFoodSelected = false
        isAfterEatingFoodSelected = false
        frequencies = []
    }
}

#Preview {
    PillDetailView() { }
}
