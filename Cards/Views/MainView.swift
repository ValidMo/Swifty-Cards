
import SwiftUI
import Charts

struct MainView: View {
    
    @FetchRequest(sortDescriptors: []) var cards: FetchedResults<Card>
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "bookmarkStatus == true")) private var bookmarked: FetchedResults<Card>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023).first) private var januaryTransactions: FetchedResults<Transaction>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023)[1]) private var februaryTransactions: FetchedResults<Transaction>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023)[2]) private var marchTransactions: FetchedResults<Transaction>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023)[3]) private var aprilTransactions: FetchedResults<Transaction>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023)[4]) private var mayTransactions: FetchedResults<Transaction>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023)[5]) private var juneTransactions: FetchedResults<Transaction>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023)[6]) private var julyTransactions: FetchedResults<Transaction>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023)[7]) private var augustTransactions: FetchedResults<Transaction>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023)[8]) private var septemberTransactions: FetchedResults<Transaction>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023)[9]) private var octoberTransactions: FetchedResults<Transaction>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023)[10]) private var novemberTransactions: FetchedResults<Transaction>
    @FetchRequest(sortDescriptors: [], predicate: createPredicateForMonths(year: 2023)[11]) private var decemberTransactions: FetchedResults<Transaction>
    
    
    @State private var isAnimated = false
    @State private var showAddAcount: Bool = false
    @State private var animateChart: Bool = false
    @Binding var AccountAddedNotification: Bool
    @Binding var TransactionDoneNotification: Bool
    @Binding var AccountEditedNotification: Bool
    @Binding var AccountDeletedNotification: Bool
    @Binding var selectedTab: Int
    
    let gradient = Gradient(colors: [.black, .pink])
    
    
    
    
    
    var body: some View {
        
        let data: [monthlyTransactionsReview] = [
              monthlyTransactionsReview(month: "Jan", transactions: transactionCalculator(januaryTransactions)),
              monthlyTransactionsReview(month: "Feb", transactions: transactionCalculator(februaryTransactions)),
              monthlyTransactionsReview(month: "Mar", transactions: transactionCalculator(marchTransactions)),
              monthlyTransactionsReview(month: "Apr", transactions: transactionCalculator(aprilTransactions)),
              monthlyTransactionsReview(month: "May", transactions: transactionCalculator(mayTransactions)),
              monthlyTransactionsReview(month: "Jun", transactions: transactionCalculator(juneTransactions)),
              monthlyTransactionsReview(month: "Jul", transactions: transactionCalculator(julyTransactions)),
              monthlyTransactionsReview(month: "Aug", transactions: transactionCalculator(augustTransactions)),
              monthlyTransactionsReview(month: "Sep", transactions: transactionCalculator(septemberTransactions)),
              monthlyTransactionsReview(month: "Oct", transactions: transactionCalculator(octoberTransactions)),
              monthlyTransactionsReview(month: "Nov", transactions: transactionCalculator(novemberTransactions)),
              monthlyTransactionsReview(month: "Dec", transactions: transactionCalculator(decemberTransactions))
          ]

        
        NavigationView {
            VStack{
                HStack(spacing: 80){
                    NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "gearshape")
                            .foregroundColor(.primary)
                            .fontWeight(.bold)
                            .font(.system(size: 20))
                    }

                    Text("Wallet")
                        .fontWeight(.heavy)
                        .font(.custom("Aldrich-Regular", size: 30))
                    Button(action: {
                        showAddAcount.toggle()
                    }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.primary)
                                .fontWeight(.bold)
                                .font(.system(size: 20))
                    }
                    .sheet(isPresented: $showAddAcount) {
                        AddCardView(AccountAddedNotification: $AccountAddedNotification)
                    }
                }
                Divider()
                    .foregroundColor(.primary)
                
                //MARK: - Bookmarked
                VStack(alignment: .leading){
                    Text("Bookmarked Cards")
                        .foregroundColor(.primary)
                        .font(.custom("Aldrich-Regular", size: 24))
                        .fontWeight(.heavy)
                        .padding(.top)
                        .padding(.leading)
                    
                    Divider()
                        .foregroundColor(.primary)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack{
                                if(bookmarked.isEmpty){
                                    blankBookmarkView()
                                        .onTapGesture {
                                            showAddAcount.toggle()
                                        }
                                        .sheet(isPresented: $showAddAcount) {
                                            AddCardView(AccountAddedNotification: $AccountAddedNotification)
                                        }
                                        
                                }
                                else{
                                    ForEach(bookmarked){ card in
                                        
                                        Button(action: {
                                           selectedTab = 2
                                        }, label: {
                                            ZStack{
                                                Rectangle()
                                                    .frame(width: 180, height: 125)
                                                    .cornerRadius(24)
                                                    .padding()
                                                    .foregroundColor(Color(UIColor(red: CGFloat(card.red), green: CGFloat(card.green), blue: CGFloat(card.blue), alpha: CGFloat(card.alpha)
                                                                                  )))
                                                VStack(spacing: 18){
                                                    Text(card.name)
                                                        .customtextForAddForMainView()
                                                    Text(card.number)
                                                        .customtextForAddForMainView()
                                                    Text(card.iban ?? "")
                                                        .font(.custom("Aldrich-Regular", size: 8))
                                                        .foregroundColor(.white)
                                                    let editedMoneyText = textCorrectorWithPoint(text: String(card.money))
                                                    
                                                    Text(String(editedMoneyText))
                                                        .customtextForAddForMainView()
                                                }
                                            }})
                                        
                                    }
                                    
                                }
                                
                            }
                            .padding()
                            
                        }
                   
                      
          
                    
                }
                //  MARK: - chart
                VStack(alignment: .leading) {
                    Text("Monthly Balance")
                        .font(.custom("Aldrich-Regular", size: 24))
                        .foregroundColor(.primary)
                    Divider()
                        .foregroundColor(.primary)
                }
                .padding()
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        Chart(data, id: \.month){ item in
                            
                            BarMark(
                                x: .value("Month", item.month),
                                y: .value("Balance", item.transactions)
                                
                            )
//                            .cornerRadius(10)
                            .foregroundStyle( item.transactions > 0 ?
                                .linearGradient(
                                    colors: [.green],
                                    startPoint: .bottom,
                                    endPoint: .top
                                )
                                              :
                                    .linearGradient(
                                        colors: [.red],
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                            )
                            
                        }
                        .frame(width:350,height: 260)
                        .chartXAxis{
                            AxisMarks()
                        }
                        .chartYAxis{
                            AxisMarks()
                        }
                        
                        .padding()
                        
                        Spacer()
                       
//                            Chart(data, id: \.month, content: { item in
//                                 
//                                 LineMark(
//                                     x: .value("Month", item.month),
//                                     y: .value("Balance", item.transactions)
//                                     
//                                 )
//
//                                 .foregroundStyle( item.transactions > 0 ?
//                                     .linearGradient(
//                                         colors: [.green],
//                                         startPoint: .bottom,
//                                         endPoint: .top
//                                     )
//                                                   :
//                                         .linearGradient(
//                                             colors: [.red],
//                                             startPoint: .top,
//                                             endPoint: .bottom
//                                         )
//                                 )
//                                 
//                             })
                           
                           
                        
                    
                        
                        .frame(width:320,height: 260)
                        .padding()
                        
                        Spacer()
                    }
                }
               
                }
        }
       
        }
    
    
    
    
    struct monthlyTransactionsReview {

    var month: String
    var transactions: Double

    }
    
    func transactionCalculator(_ transactions: FetchedResults<Transaction>) -> Double {
        
        var result = [Double]()
        
        for transaction in transactions {
            result.append(transaction.amount)
        }
        
        return result.reduce(0, +)
    }

 
    

}

struct blankBookmarkView: View {
    
    var body: some View {
        ZStack{
            
            Rectangle()
                .frame(width: 180, height: 125)
                .cornerRadius(24)
                .foregroundColor(Color.gray)
                .shadow(color:.gray, radius: 4,x: 0, y:0)
            
                Image(systemName: "plus.circle")
                    .foregroundColor(.white)
        }
    }
    
}

