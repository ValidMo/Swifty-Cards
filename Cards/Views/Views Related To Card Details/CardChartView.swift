//
//  CardChartView.swift
//  Cards
//
//  Created by Valid Mohammadi on 19.09.2023.
//



import SwiftUI
import Charts



struct CardChartView: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        Text("This will be chart view")
            .foregroundColor(colorScheme == .dark ? .green : .yellow)
    }
}

struct CardChartView_Previews: PreviewProvider {
    static var previews: some View {
        CardChartView()
    }
}
