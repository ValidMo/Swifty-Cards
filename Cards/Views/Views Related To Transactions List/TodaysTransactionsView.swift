

import SwiftUI

struct TodaysTransactionsView: View {
    
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: true)],
           predicate: NSPredicate(format: "date >= %@ AND date < %@", argumentArray: [Date().startOfDay, Date().endOfDay]),
           animation: .default)
       private var transactions: FetchedResults<Transaction>
    
    var dateFormatter = DateFormatter()
     
    
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
                                        .foregroundColor(.primary )
                                        .font(.custom("Aldrich-Regular", size: 15))
                                    Text(transaction.transactionToCard?.number ?? "")
                                        .foregroundColor(.secondary )
                                        .font(.custom("Aldrich-Regular", size: 12))
                                    Text(transaction.transactionToCard?.name ?? "")
                                        .foregroundColor(.secondary)
                                        .font(.custom("Aldrich-Regular", size: 12))
                                   
                                    Text(dateToString(date: transaction.date))
                                        .foregroundColor(.secondary)
                                        .font(.custom("Aldrich-Regular", size: 12))
                                         
                                    
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

func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YY/MM/dd"
    
    return dateFormatter.string(from: date)
}
