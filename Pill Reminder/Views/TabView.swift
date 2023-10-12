//
//  TabView.swift
//  Pill Reminder
//
//  Created by Soyeon Lee on 10/10/23.
//

import SwiftUI

struct TabView: View {
    
    @Binding var selectedTab: Tab
    @State var pill: Pill
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                
                Spacer()
                Image(systemName: tab.rawValue)
                    .scaleEffect(tab == selectedTab ? 1.25 : 1.0)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.1)) {
                            selectedTab = tab
                        }
                    }
                Spacer()
            }
        }
        .frame(width: nil, height: 60)
        .background(.thinMaterial) // Use Color to set the background color
        .cornerRadius(10)
        .padding()
    }
}

#Preview {
    TabView(selectedTab: .constant(.house), pill: Pill())
}


