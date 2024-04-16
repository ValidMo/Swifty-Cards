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
        Text("Hi my name is Noyan, you can visit my website https://noyan.me ")
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
