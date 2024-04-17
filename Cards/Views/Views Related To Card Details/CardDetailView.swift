
import SwiftUI
import UIKit

struct CardDetailView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var card: Card
    
    @State var showAlert: Bool = false
    @State var showShareSheet: Bool = false
    @State var showEditSheet: Bool = false
    @State var showFutureTransactionSheet: Bool = false
    @State var addSubMoney: String = ""
    @State var addDescription: String = ""
    
    @Binding var TransactionDoneNotification: Bool
    @Binding var AccountEditedNotification: Bool
    @Binding var AccountDeletedNotification: Bool

    private let pasteBoard = UIPasteboard.general
    
    var body: some View {
      //MARK: - The Card
        
            VStack{
                ZStack{
                    Rectangle()
                        .frame(width: 360, height: 250)
                        .foregroundColor(Color(UIColor(red: CGFloat(card.red), green: CGFloat(card.green), blue: CGFloat(card.blue), alpha: CGFloat(card.alpha)
                                                      ))) //Hard Coded
                        .cornerRadius(24)
                        .padding()
                    
                        VStack(spacing: 10){
                            VStack(spacing: 18){
                                ZStack{
                                    Text(card.name)
                                        .customText()
                                    HStack{
                                        Spacer()
                                        Button {
                                            showEditSheet.toggle()
                                        } label: {
                                            Image(systemName: "square.and.pencil")
                                                .foregroundColor(.white)
                                                .scaleEffect(1.3)
                                            
                                        }
                                        .padding(.trailing, 45)
                                       
                                        .sheet(isPresented: $showEditSheet) {
                                            EditCardView(
                                                cardToEdit: card,
                                                AccountEditedNotification: $AccountEditedNotification,
                                                AccountDeletedNotification: $AccountDeletedNotification)
                                        }
                                    }
                                }
                                Text(card.number)
                                    .customText()
                                Text(card.iban ?? "")
                                    .font(.custom("Aldrich-Regular", size: 16))
                                    .foregroundColor(.white)
                                let editedMoneyText = textCorrectorWithPoint(text: String(card.money))
                                
                                Text(String(editedMoneyText))
                                    .customText()
                                
                                HStack(spacing: 32) {
                                    NavigationLink(destination: {
                                        CardChartView()
                                    } , label: {
                                        Image("Charts") //
                                            .resizable()
                                            .padding(.all, 13)
                                            .scaledToFit()
                                            .fontWeight(.bold)
                                    })
                                    .font(.custom("Aldrich-Regular", size: 18))
                                    .frame(width:55, height: 55)
                                    .background()
                                    .backgroundStyle(.white)
                                    .cornerRadius(10)
                                    //MARK: - HERE
                                    
                                    Button(action: {
                                        showFutureTransactionSheet.toggle()
                                    }, label: {
                                        Image("FutureDate") //
                                            .resizable()
                                            .padding(.all, 8)
                                            .scaledToFit()
                                    })
                                    .frame(width: 55, height: 55)
                                    .background()
                                    .backgroundStyle(.white)
                                    .cornerRadius(10)
                                    .padding(.trailing, 105)
                                    .sheet(isPresented: $showFutureTransactionSheet) {
                                        AddFutureTransactionView(card: card)
                                    }
                                    
                                
                                    
                                    Button {
                                        showAlert = true
                                    } label: {
                                        Image("shareIconLight")
                                    }
                                    .alert("Which information do you want to share", isPresented: $showAlert) {
                                        Button("Card Number"){
                                            pasteBoard.string = card.number
                                            showShareSheet = true
                                        }
                                        Button("IBAN Number"){
                                            pasteBoard.string = card.iban
                                            showShareSheet = true
                                        }
                                    }
                                }
                                .sheet(isPresented: $showShareSheet) {
                                    ActivityView(activityItems: [pasteBoard.string ?? ""])
                                    
                                }
                            }
                        }

                }
                //MARK: - TextFields
                VStack(spacing: 45){
//                    TextField("amount e.g : $123.4", text: $addSubMoney)
//                        .customTextField()
                    TextField("$123.45", text: $addSubMoney)
                        .customTextField()
                        .keyboardType(.decimalPad)
                        .onChange(of: addSubMoney){ _ in
                            // Remove all non-digit characters from the input
                            var sanitizedInput = addSubMoney.filter { $0.isNumber || $0 == "." }
                            if let dotIndex = sanitizedInput.firstIndex(of: ".") {
                                    let decimalDigits = sanitizedInput[dotIndex...].dropFirst()
                                    if decimalDigits.count > 3 {
                                        sanitizedInput = String(sanitizedInput.prefix(upTo: dotIndex)) + "." + decimalDigits.prefix(2 + 1)
                                    }
                                }

                            addSubMoney = sanitizedInput
                    }
                    TextField("Description", text: $addDescription)
                        .customTextField()
                //MARK: - Buttons
                    HStack(spacing:20)
                    {
                        
                        Button {
                            if let addMoney = Double(addSubMoney){
                                card.money += addMoney
                                DataController().addTransaction(card: card, date: Date(), amount: addMoney, desc: addDescription, notificationStatus: false, context: managedObjectContext)
                            }
                            print(addDescription)
                            TransactionDoneNotification = true
                            DataController().save(context: managedObjectContext)
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            ZStack{
                                Rectangle()
                                    
                                    .foregroundColor((!addSubMoney.isEmpty && !addDescription.isEmpty) ?
                                                     Color(red: 72/255, green: 233/255, blue: 99/255) :
                                                         Color(red: 205/255, green: 233/255, blue: 221/255))
                                    .frame(width: 165, height: 55)
                                    .cornerRadius(30)
                                   
                                Text("+")
                                    .font(.custom("Aldrich-Regular", size: 30))
                                    .foregroundColor(.white)
                            }
                            
                        }
                        .disabled(addSubMoney.isEmpty || addDescription.isEmpty )

                       
                        Button(action: {
                                if let subMoney = Double(addSubMoney){
                                    card.money -= subMoney
                                    DataController().addTransaction(card: card, date: Date(), amount: -subMoney, desc: addDescription, notificationStatus: false, context: managedObjectContext)
                                }
                                
                                DataController().save(context: managedObjectContext)
                                TransactionDoneNotification = true
                                presentationMode.wrappedValue.dismiss()
                                
                            
                        }, label: {
                            ZStack{
                                Rectangle()
                                    
                                    .foregroundColor((!addSubMoney.isEmpty && !addDescription.isEmpty) ?
                                                Color(red: 255/255, green: 53/255, blue: 72/255) :
                                                 Color(red: 255/255, green: 135/255, blue: 149/255))
                                    .frame(width: 165, height: 55)
                                    .cornerRadius(30)
                                   
                                Text("-")
                                    .font(.custom("Aldrich-Regular", size: 30))
                                    .foregroundColor(.white)
                            }
                          
                        })
                        .disabled(addSubMoney.isEmpty || addDescription.isEmpty )
                    }
                    
                }
                
                Spacer()
            }
        }
}
    
extension Button {
    func calculatorStyle() -> some View {
        return VStack{
            
            ZStack{
                
                Rectangle()
                    .cornerRadius(12)
                    .foregroundColor(.gray)
                    .frame(width: 70, height: 72)
                    .position(x:196.5, y:385)
                
                Rectangle()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.yellow)
                    .cornerRadius(10)
                Rectangle()
                    .frame(width: 8, height: 30)
                    .cornerRadius(10)
                    .foregroundColor(.green)
                Rectangle()
                    .frame(width: 30, height: 8)
                    .cornerRadius(10)
                    .foregroundColor(.green)
                
            }
            
        }
    }
}
    
