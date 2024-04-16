//
//  Text.swift
//  Cards
//
//  Created by Valid Mohammadi on 20.09.2023.
//

import Foundation
import SwiftUI

//MARK: - Extensions

extension TextField {
    
    func customTextField() -> some View {
        return self
            .foregroundColor(.primary)
            .padding(.leading, 20)
            .font(.custom("Aldrich-Regular", size: 28))
            .disableAutocorrection(true)
            .frame(width: 340, height: 78)
            
            .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color("TextField"))
                .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 5, y: 5)
            )
    }
    
    func customTextFieldForIBAN() -> some View {
        return self
            .foregroundColor(.primary)
            .padding(.leading, 20)
            .font(.custom("Aldrich-Regular", size: 17))
            .disableAutocorrection(true)
            .frame(width: 340, height: 78)
            
            .background(
            RoundedRectangle(cornerRadius: 24)
                .fill(Color("TextField"))
                .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 5, y: 5)
            )
    }
    
}


extension Text {
    func customTextForAddCardView() -> some View {
        return self
            .font(.custom("Aldrich-Regular", size: 4))
            .foregroundColor(.white)
    }
    
    
    func customtextForAddForMainView() -> some View {
        return self
            .font(.custom("Aldrich-Regular", size: 10))
            .foregroundColor(.white)
    }
}
    /*
extension Toggle {
    func customToggleField() -> some View {
        return self
            .foregroundColor(Color.gray.opacity(0.7))
            .padding(.leading, 20)
            .font(.custom("Aldrich-Regular", size: 14))
           .frame(width: 350, height: 50)
           
        
    }
}
     */

//MARK: - Functions

func StringToDoubleForMoney(moneyInString: String) -> Double{
    
    let actualMoney = moneyInString.filter{$0.isNumber || $0 == "."}
    if let money = Double(actualMoney){
        return money
    }
    return 0.0
  }

func textCorrectorWithPoint(text: String) -> [Character] {
    
    var output = [Character]()
    var counter = -2
    var toggle = false
    
    for word in text.reversed(){
        
        if word == "." {
            toggle.toggle()
        }
        
        if (toggle && counter < 3) {
            counter += 1
          
        }
        
        if (counter == 3) {
            output.append("'")
            counter = 0
        }

        output.append(word)
    }
    
    return output.reversed()
    
}

func textCorrectorWithoutPoint(text: String) -> [Character] {
    
    var output = [Character]()
    var counter = -2
    for word in text.reversed(){
        if ( counter < 3) {
            counter += 1
        }
        
        if (counter == 3) {
            output.append("'")
            counter = 0
        }

        output.append(word)
    }
    
    return output.reversed()
    
}
