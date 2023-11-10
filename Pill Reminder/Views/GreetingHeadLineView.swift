//
//  GreetingHeadLineView.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 11/9/23.
//

import SwiftUI

struct GreetingHeadLineView: View {
    
    @ObservedObject var dateViewModel = DateViewModel()

    var body: some View {
        VStack(alignment: .leading) {
            Text("Pill Reminder")
                .foregroundColor(.white)
                .bold()
                .padding(.leading, 100)
            
            Image(systemName: "bell.fill")
                .resizable()
                .frame(width: 20, height: 20)
                .padding(.leading, 320)
            
            Text("Good \(dateViewModel.getGreetingHeadLine())")
                .bold()
                .font(.system(size: 30))
                .padding(.leading, 7)
            
            Text("We will remind you of the mecidines you need to take today")
                .font(.system(size: 14))
                .padding(.leading, 7)
                .padding(.trailing, 7)
        }
        .foregroundColor(.white)
    }
}

#Preview {
    GreetingHeadLineView()
        .background(Color.blue)
}
