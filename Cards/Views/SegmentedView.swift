//
//  SegmentedViewTest.swift
//  WALL-ET
//
//  Created by Valid Mohammadi on 9.07.2023.
//

//this view is hard coded:)

import SwiftUI

struct SegmentedView: View {
    @State private var selectedSegment = 0
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack{
            Picker("", selection: $selectedSegment) {
                Text("Today").tag(0)
                Text("Yesterday").tag(1)
                Text("Last Week").tag(2)
                Text("Future").tag(3)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
           
            
            
            VStack {
                
                TabView(selection: $selectedSegment) {
                    TodaysTransactionsView()
                        .tag(0)
                    YesterdaysTransactionsView()
                        .tag(1)
                    LastWeekTransactionsView()
                        .tag(2)
                    FutureTransactionListView()
                        .tag(3)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}

struct SegmentedView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedView(selectedTab: .constant(0))
    }
}

