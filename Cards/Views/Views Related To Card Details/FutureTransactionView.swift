

import SwiftUI

struct FutureTransactionView: View {
    
    
    //    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var card: Card
    @State var theDate: Date = Date.now
    @State var notificationState: Bool = false
    @State var showAddFutureTransaction: Bool = false
    let tommorow: Date = Date.now.addingTimeInterval(86400)
    
        var body: some View {
    
            Text("This will be Future Transaction View")
//                List{
//                    ForEach(transactions) { transaction in
//
//                        HStack{
//                            Text(String(format: "%.2f", transaction.amount))
//                                .foregroundColor(transaction.amount > 0 ? .green : .red)
//                            Spacer()
//                            Text("\(transaction.description)")
//                                .foregroundColor(Color(.lightGray))
//                            Spacer()
//                            if let formattedDate = formatDate(date: theDate) {
//                                    Text(formattedDate)
//                                }
//                        }
//                        .environment(\.locale, Locale(identifier: "en_US"))
//                    }
//                    .onDelete { _ in
//                        print("row deleted")
//                    }
//
//                }
//                .navigationBarTitle("Future Transactions")
//                .navigationBarItems(trailing:
//                                        Button(action: {
//                    showAddFutureTransaction.toggle()
//                }, label: {
//                    Image(systemName: "plus.circle")
//                })
//                                    )
//                .sheet(isPresented: $showAddFutureTransaction) {
//                    AddFutureTransactionView(card: card)
//                }
//
//
//
//
//
//    //        }
//
        }
    }
    


func formatDate(date: Date) -> String? {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US")
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter.string(from: date)
}

//struct FutureTransactionView_Previews: PreviewProvider {
//    static var previews: some View {
//        FutureTransactionView(card: Card(cardName: "Some Card", cardNumber: "1234 5678 9012 3456", IBANNumber: "TR143193812131", money: 33200, color: .pink),theDate: Date.now, notificationState: false, showAddFutureTransaction: false, transactions: )
//    }
//}
