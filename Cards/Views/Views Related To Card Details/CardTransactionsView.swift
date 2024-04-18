//
//  CardChartView.swift
//  Cards
//
//  Created by Valid Mohammadi on 19.09.2023.
//



import SwiftUI
import CoreData

struct CardTransactionsView: View {
    @ObservedObject var card: Card
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: true)],
        animation: .default
    ) private var transactions: FetchedResults<Transaction>

    init(card: Card) {
        self.card = card
        _transactions = FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Transaction.date, ascending: true)],
            predicate: NSPredicate(format: "transactionToCard == %@", card)
        )
    }

    var body: some View {
        NavigationView{
            ZStack{
                VStack(alignment: .leading, spacing: 0){
                    ScrollView{
                        ForEach(transactions) { transaction in
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
        .navigationTitle("Transactions")
        .font(.custom("Aldrich-Regular", size: 35))    }
}

