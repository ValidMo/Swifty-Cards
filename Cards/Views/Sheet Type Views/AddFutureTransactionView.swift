

import SwiftUI

struct AddFutureTransactionView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @ObservedObject var card: Card
    @State var theDate: Date = Date.now
    @State var notificationState: Bool = false
    @State var addSubMoney: String = ""
    @State var addDescription: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    @State private var notificationAuthorizationStatus: UNAuthorizationStatus = .notDetermined
    

    var body: some View {
        VStack(spacing: 45){
            Text("A Transaction in future")
                .font(.custom("Aldrich-Regular", size: 27))
            Divider()
            TextField("amount e.g : $123.4", text: $addSubMoney)
                .customTextField()
                .keyboardType(.decimalPad)
            TextField("Description", text: $addDescription)
                .customTextField()
            ZStack{
              
                RoundedRectangle(cornerRadius: 24)
                   
                        .fill(Color.white)
                        .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 5, y: 5)
                        .frame(width: 350, height: 80)
                HStack(spacing: 63){
                    Text("Pick Date")
                        .font(.custom("Aldrich-Regular", size: 26))
                        .foregroundColor(Color(.black))
                    DatePicker("", selection: $theDate, in: Date()..., displayedComponents: .date)
                        .labelsHidden()
                    
                }
            }
            ZStack{
                RoundedRectangle(cornerRadius: 24)
                
                    .fill(Color.white)
                    .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 5, y: 5)
                    .frame(width: 350, height: 80)
                VStack{
                    HStack(spacing: 110){
                        Text("Remind me")
                            .foregroundColor(Color(.black))
                            .font(.custom("Aldrich-Regular", size: 28))
                        Toggle("Remind me!", isOn: $notificationState)
                            .labelsHidden()
                            .onChange(of: notificationState) { _ in
                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
                                    DispatchQueue.main.async {
                                        // Update notificationState based on the authorization status
                                        if granted {
                                            // User granted permission, you can handle this as needed
                                        } else {
                                            // User denied permission, update notificationState accordingly
                                            notificationState = false
                                        }
                                    }
                                }
                            }
                            .disabled(notificationAuthorizationStatus == .denied)
                    }
                    Text("Notification will pop-up one week, one day, one hour before the scheduled date")
                        .font(.custom("Aldrich-Regular", size: 10))
                        .foregroundColor(.gray)
                }
            }
            
            HStack(spacing:20)
            {
                Button("+"){
                    if let addMoney = Double(addSubMoney){
                        card.money += addMoney
                        DataController().addTransactionInFuture(card: card, date: theDate, amount: addMoney, desc: addDescription, notificationStatus: notificationState, context: managedObjectContext)
                    }
                    
//                    TransactionDoneNotification = true
                    
                    presentationMode.wrappedValue.dismiss()
                }
                .font(.custom("Aldrich-Regular", size: 30))
                .frame(width: 165, height: 55)
                .foregroundColor(.white)
                .background((!addSubMoney.isEmpty && !addDescription.isEmpty) ?
                            Color(red: 72/255, green: 233/255, blue: 99/255) :
                                Color(red: 205/255, green: 233/255, blue: 221/255))
                .cornerRadius(30)
                .disabled(addSubMoney.isEmpty || addDescription.isEmpty)
                .gesture(TapGesture().onEnded({
                    
                }))
                
                
                
                Button("-"){
                    if let subMoney = Double(addSubMoney){
                        card.money -= subMoney
                        DataController().addTransactionInFuture(card: card, date: theDate, amount: -subMoney, desc: addDescription, notificationStatus: notificationState, context: managedObjectContext)
                    }
                    
//                    TransactionDoneNotification = true check this
                    
                    
                    presentationMode.wrappedValue.dismiss()
                    
                }
                .font(.custom("Aldrich-Regular", size: 30))
                .foregroundColor(.white)
                .frame(width: 165, height: 55)
                .background((!addSubMoney.isEmpty && !addDescription.isEmpty) ?
                            Color(red: 255/255, green: 53/255, blue: 72/255)
                            
                            : Color(red: 255/255, green: 135/255, blue: 149/255))
                .cornerRadius(30)
                .disabled(addSubMoney.isEmpty || addDescription.isEmpty )
            }
            
        }
    }
}

    func Transact() {
    
}
