//
//  SettingView.swift
//  Cards
//
//  Created by Valid Mohammadi on 30.09.2023.
//

import SwiftUI
import MessageUI

struct SettingView: View {
    
   
    
    
    
    @State private var darkModeStatus: Bool = false
    @State private var notificationStatus: Bool = false
    @State private var showAboutUsView: Bool = false
    @State private var feedbackStatus: Bool = false
    
    var body: some View {
       
        VStack(alignment: .leading, spacing: 10){
            Text("Setting")
                .padding()
                .font(.custom("Aldrich-Regular", size: 35))
            Divider()
            Toggle("Dark Mode", isOn: $darkModeStatus)
                .padding()
                .font(.custom("Aldrich-Regular", size: 25))
         
            Toggle("Notification", isOn: $notificationStatus)
                .padding()
                .font(.custom("Aldrich-Regular", size: 25))
            
            
            Divider()
    
            Button("Feed us back") {
                print("Nothing yet")
            }
            .padding()
            .font(.custom("Aldrich-Regular", size: 25))
            
            Divider()
            Button("About us") {
                showAboutUsView.toggle()
            }
            .padding()
            .font(.custom("Aldrich-Regular", size: 25))
            .sheet(isPresented: $showAboutUsView){
                AboutUsView()
            }
            
            Spacer()
          
                
               
            Text("Version: 1.0.0")
                .foregroundColor(.gray)
                .padding()
                .font(.custom("Aldrich-Regular", size: 15))
                

           
        }
        
        
        
        
        
        
       
    }
}

//struct SettingView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingView(darkModeStatus: true, notificationStatus: true)
//    }
//}
