
import SwiftUI

struct ContentView: View {
    
    @State var TransactionDoneNotification: Bool = false
    @State var CardAddedNotification: Bool = false
    @State var CardEditedNotification: Bool = false
    @State var CardDeletedNotification: Bool = false
    @State private var selectedTab: Int = 1
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(.white)
    }
    
    var body: some View {
        
        
        TabView(selection: $selectedTab){
            
            MainView(
                AccountAddedNotification: $CardAddedNotification,
                TransactionDoneNotification: $TransactionDoneNotification,
                AccountEditedNotification: $CardEditedNotification,
                AccountDeletedNotification: $CardDeletedNotification,
                selectedTab: $selectedTab
            )
            .tabItem {
                Label("Wallet", systemImage: "creditcard.circle.fill")
//                VStack {
////                       Image(systemName: "person.circle")
//                       Text("Profile")
//                        .font(.custom("Aldrich-Regular", size: 10))
//                   }
            }
            .tag(1)
        
            
            AllCardsView(
                TransactionDoneNotification: $TransactionDoneNotification,
                AccountEditedNotification: $CardEditedNotification,
                AccountDeletedNotification: $CardDeletedNotification,
                selectedTab: $selectedTab)
            .tabItem {
                Label("Cards", systemImage: "list.bullet.circle.fill")
                
            }
            .tag(2)
            
            SegmentedView(selectedTab: $selectedTab)
            .tabItem{
                Label("Transactions", systemImage: "clock.fill")
            }
            .tag(3)
  
            }
            
            
            .overlay(
                VStack{
                    if TransactionDoneNotification {
                        NotificationView(notificationText: Notification.Transaction.rawValue)
                            .frame(height: 60)
                            .padding(.top)
                            .animation(.easeInOut)
                            .transition(.move(edge: .top))
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                    TransactionDoneNotification = false
                                }
                            }
                        
                        
                    }
                    if CardAddedNotification {
                        NotificationView(notificationText: Notification.AccountAdded.rawValue)
                            .frame(height: 60)
                            .padding(.top)
                            .animation(.easeInOut)
                            .transition(.move(edge: .top))
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                    CardAddedNotification = false
                                }
                            }
                        
                        
                    }
                    if CardEditedNotification {
                        NotificationView(notificationText: Notification.AccountEdited.rawValue)
                            .frame(height: 60)
                            .padding(.top)
                            .animation(.easeInOut)
                            .transition(.move(edge: .top))
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                    CardEditedNotification = false
                                }
                            }
                        
                        
                    }
                    if CardDeletedNotification {
                        NotificationView(notificationText: Notification.AccountDeleted.rawValue)
                            .frame(height: 60)
                            .padding(.top)
                            .animation(.easeInOut)
                            .transition(.move(edge: .top))
                            .onAppear{
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                                    CardDeletedNotification = false
                                }
                            }
                        
                        
                    }
                    Spacer()
                }
                
                
            )
            
            
            
            
        }
        
        
    }
    

