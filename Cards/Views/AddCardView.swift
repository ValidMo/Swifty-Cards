

import SwiftUI

struct AddCardView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - Properties for Adding
    
    @State private var name: String = ""
    @State private var number: String = ""
    @State private var iban: String = ""
    @State private var moneyInString: String = ""
    @State private var color: Color = .gray

    @Binding var AccountAddedNotification: Bool
    

    //MARK: - The Body
        var body: some View {
            
            VStack(alignment: .center, spacing: 30){

                VStack(alignment: .center, spacing: 15){
                    
                    //MARK: - Header
                    Text("Add Card")
                        .font(.custom("Aldrich-Regular", size: 30))
                        .padding(.top)
                    
                    Divider()
                    //MARK: - TextFields
                    TextField("Card Name", text: $name)
                        .customTextField()
                        .onChange(of: name, perform: { newValue in
                            if name.count > 16 {
                                let tranquatedName = String(name.prefix(20))
                                name = tranquatedName
                            }
                        })
                    
                     
                        
                    
                    TextField("Card Number", text: $number)
                        .customTextField()
                        .keyboardType(.decimalPad)
                                .onChange(of: number) { newValue in
                                    
                                    // Remove all spaces from the card number
                                    let strippedNumber = number.replacingOccurrences(of: " ", with: "")
                                    
                                    if strippedNumber.count > 16 {
                                        
                                        let tranquatedNumber = String(strippedNumber.prefix(16))
                                        // Add a space after every 4 digits
                                        let formattedNumber = stride(from: 0, to: tranquatedNumber.count, by: 4).map {
                                            let startIndex = strippedNumber.index(tranquatedNumber.startIndex, offsetBy: $0)
                                            let endIndex = tranquatedNumber.index(startIndex, offsetBy: 4, limitedBy: tranquatedNumber.endIndex) ?? tranquatedNumber.endIndex
                                            return String(tranquatedNumber[startIndex..<endIndex])
                                        }.joined(separator: " ")
                                        
                                        // Update the card number with the formatted version
                                        number = formattedNumber
                                    }
                                    
                                    else {
                                        let formattedNumber = stride(from: 0, to: strippedNumber.count, by: 4).map {
                                            let startIndex = strippedNumber.index(strippedNumber.startIndex, offsetBy: $0)
                                            let endIndex = strippedNumber.index(startIndex, offsetBy: 4, limitedBy: strippedNumber.endIndex) ?? strippedNumber.endIndex
                                            return String(strippedNumber[startIndex..<endIndex])
                                        }.joined(separator: " ")
                                        

                                        number = formattedNumber
                                    }
                                }
                       
                    TextField("IBAN Number", text: $iban)
                        .customTextFieldForIBAN()
                        .onChange(of: iban, perform: { newValue in
                            let strippedIban = iban.replacingOccurrences(of: " ", with: "")
                            
                            if strippedIban.count > 26 {
                                
                                let tranquatedIban = String(strippedIban.prefix(26))
                                let formattedIban = stride(from: 0, to: tranquatedIban.count, by: 4).map {
                                    let startIndex = tranquatedIban.index(tranquatedIban.startIndex, offsetBy: $0)
                                    let endIndex = tranquatedIban.index(startIndex, offsetBy: 4, limitedBy: tranquatedIban.endIndex) ?? tranquatedIban.endIndex
                                    return String(strippedIban[startIndex..<endIndex])
                                }.joined(separator: " ")
                                iban = formattedIban
                            }
                            else {
                                let formattedIban = stride(from: 0, to: strippedIban.count, by: 4).map {
                                    let startIndex = strippedIban.index(strippedIban.startIndex, offsetBy: $0)
                                    let endIndex = strippedIban.index(startIndex, offsetBy: 4, limitedBy: strippedIban.endIndex) ?? strippedIban.endIndex
                                    return String(strippedIban[startIndex..<endIndex])
                                }.joined(separator: " ")
                                iban = formattedIban
                            }
                        }
                      
                        )

                   
                    TextField("$123.45", text: $moneyInString)
                        .customTextField()
                        .keyboardType(.decimalPad)
                        .onChange(of: moneyInString){ _ in
                            // Remove all non-digit characters from the input
                            var sanitizedInput = moneyInString.filter { $0.isNumber || $0 == "." }
                            if let dotIndex = sanitizedInput.firstIndex(of: ".") {
                                    let decimalDigits = sanitizedInput[dotIndex...].dropFirst()
                                    if decimalDigits.count > 3 {
                                        sanitizedInput = String(sanitizedInput.prefix(upTo: dotIndex)) + "." + decimalDigits.prefix(2 + 1)
                                    }
                                }

                            moneyInString = sanitizedInput
                    }
                       
                    
                    //MARK: - The ColorPicker and the preview of card
                    ColorPicker(selection: $color, supportsOpacity: false) {
                        ZStack{
                            Rectangle()
                                .frame(width: 120, height: 92)
                                .cornerRadius(24)
                                .padding()
                                .foregroundColor(color)
                            VStack(spacing: 10){
                                Text(name)
                                    .customtextForAddForMainView()
                                Text(number)
                                    .customtextForAddForMainView()
                                Text(iban)
                                    .font(.custom("Aldrich-Regular", size: 6))
                                    .foregroundColor(.white)
                                Text(String(moneyInString))
                                    .customtextForAddForMainView()
                            }
                            
                            
                        }
                    }
                }
               
//                
//                Spacer()
//                
                
                //MARK: - Adding the card
                Button("Done") {
                    
                    DataController().addCard(name: name, number: number, iban: iban, money: StringToDoubleForMoney( moneyInString: moneyInString), bookmarkStatus: false, color: color, context: managedObjectContext)
                    AccountAddedNotification = true
                    presentationMode.wrappedValue.dismiss()

                }
                .disabled(name.isEmpty || number.isEmpty || iban.isEmpty || moneyInString.isEmpty)
                .font(.custom("Aldrich-Regular", size: 30))
                .frame(width: 330, height: 50)
                .background((!name.isEmpty && !number.isEmpty && !iban.isEmpty && !moneyInString.isEmpty) ?
                            Color(red: 72/255, green: 233/255, blue: 99/255) :
                            Color(red: 205/255, green: 233/255, blue: 221/255))
                .foregroundColor(.white)
                .cornerRadius(30)
                
            }
            .padding(.all)
        }

}





