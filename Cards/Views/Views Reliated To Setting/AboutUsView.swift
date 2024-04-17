//
//  AboutUsView.swift
//  Cards
//
//  Created by Valid Mohammadi on 2.10.2023.
//

import SwiftUI

struct AboutUsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center){
            Text("Visit my website")
                .font(.custom("Aldrich-Regular", size: 20))
                .padding()
               
        Text("https://noyan.me ")
                .customText()
                .frame(width: 340, height: 78)
                
                .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color("TextField"))
                    .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 5, y: 5)
                )
        }
        
        
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
