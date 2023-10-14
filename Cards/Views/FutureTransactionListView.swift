

import SwiftUI

struct FutureTransactionListView: View {
    
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \TransactionInFuture.date, ascending: true)],
           predicate: NSPredicate(format: "date > %@ ", argumentArray: [Date().endOfDay]),
           animation: .default)
       private var transactions: FetchedResults<TransactionInFuture>
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 0){
                ScrollView{
                    ForEach(transactions) { transaction in
                        Divider()
                        ZStack{
                            Rectangle()
                                .frame(height: 90)
                                .foregroundColor(Color("BlackOndarkWhiteOnLight"))
                            HStack(){
                                VStack(alignment: .leading, spacing: 10){
                                    Text(transaction.desc ?? "")
                                        .lineLimit(1)
                                        .foregroundColor(.primary)
                                        .font(.custom("Aldrich-Regular", size: 15))
                                    
                                    Text(transaction.transactionInFutureToCard.number)
                                        .foregroundColor(.secondary)
                                        .font(.custom("Aldrich-Regular", size: 12))
                                    Text(transaction.transactionInFutureToCard.name)
                                        .foregroundColor(.secondary)
                                        .font(.custom("Aldrich-Regular", size: 12))
                                    if let date = transaction.date {
                                    Text(dateToString(date: date))
                                        .foregroundColor(.secondary)
                                        .font(.custom("Aldrich-Regular", size: 12))
                                         }
                                }
                                .padding()
                                Spacer()
                                Text(String(transaction.amount))
                                    .font(.custom("Aldrich-Regular", size: 14))
                                    .foregroundColor((transaction.amount > 0 ? .green : .red))
                                
                                    .lineLimit(1)
                                    .padding()
                                
                            }
                        }
                        Divider()
                    }
                }
            }
        }

    }
}
