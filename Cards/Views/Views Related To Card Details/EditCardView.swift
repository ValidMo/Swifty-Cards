

import SwiftUI

struct EditCardView: View {
    
    @ObservedObject var cardToEdit: Card
    @FetchRequest(sortDescriptors: []) var cards: FetchedResults<Card>
    @Environment(\.managedObjectContext) var mananagedObjectContext
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var editedName: String = ""
    @State private var editedNumber: String = ""
    @State private var editedIBAN: String = ""
    @State private var editedMoney: String = ""
    @State private var editedColor: Color = .gray
    
    @Binding var AccountEditedNotification: Bool
    @Binding var AccountDeletedNotification: Bool
   
    
  
    
    var body: some View {
        VStack(alignment: .center, spacing: 30){
        VStack(alignment: .center, spacing: 15){
            Text("Edit Card")
                .font(.custom("Aldrich-Regular", size: 30))
                .padding(.top)
            Divider()
            TextField("Edit Card Name", text: $editedName)
                .customTextField()
            TextField("Edit Card Number", text: $editedNumber)
                .customTextField()
                .keyboardType(.decimalPad)
            TextField("Edit Card IBAN", text: $editedIBAN)
                .customTextField()
            
            ColorPicker(selection: $editedColor, supportsOpacity: false) {
                ZStack{
                    Rectangle()
                        .frame(width: 190, height: 135)
                        .cornerRadius(24)
                        .padding()
                        .foregroundColor(editedColor)
                    VStack(spacing: 18){
                        Text(editedName)
                            .customtextForAddForMainView()
                        Text(editedNumber)
                            .customtextForAddForMainView()
                        Text(editedIBAN)
                            .font(.custom("Aldrich-Regular", size: 10))
                            .foregroundColor(.white)
                        Text(String(editedMoney))
                            .customtextForAddForMainView()
                    }
                    
                }
            }
            Spacer()
        }
            Button(action: {
                AccountDeletedNotification.toggle()
                DataController().deleteCard(card: cardToEdit, context: mananagedObjectContext)
                presentationMode.wrappedValue.dismiss()
            } ,label: {
                Image(systemName: "trash.fill")
                    .padding()
            })
            
            .font(.custom("Aldrich-Regular", size: 45))
            .frame(width: 330, height: 50)
            .background(Color(.red))
            .foregroundColor(.white)
            .cornerRadius(30)
            
            Button("Done") {
                DataController().editCard(card: cardToEdit, name: editedName, number: editedNumber, iban: editedIBAN, money: Double(editedMoney) ?? 0.0, color: editedColor, context: mananagedObjectContext)
               //Hard Coded
                AccountEditedNotification.toggle()
                presentationMode.wrappedValue.dismiss()
            }
            .disabled(editedName.isEmpty || editedNumber.isEmpty || editedIBAN.isEmpty)
            .font(.custom("Aldrich-Regular", size: 30))
            .frame(width: 330, height: 50)
            .background((!editedName.isEmpty && !editedNumber.isEmpty && !editedIBAN.isEmpty) ?
                        Color(red: 72/255, green: 233/255, blue: 99/255) :
                        Color(red: 205/255, green: 233/255, blue: 221/255))
            .foregroundColor(.white)
            .cornerRadius(30)
            
          
            
         
        }
        .onAppear{
            editedName = cardToEdit.name
            editedNumber = cardToEdit.number
            editedIBAN = cardToEdit.iban ?? ""
            editedMoney = String(cardToEdit.money)
            editedColor = Color(UIColor(red: CGFloat(cardToEdit.red), green: CGFloat(cardToEdit.green), blue: CGFloat(cardToEdit.blue), alpha: CGFloat(cardToEdit.alpha)
                                       ))
        }
        .padding(.all)
    }
    
    
}
