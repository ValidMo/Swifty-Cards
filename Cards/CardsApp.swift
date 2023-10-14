

import SwiftUI

@main
struct CardsApp: App {
    
    let dataController: DataController = DataController()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.containter.viewContext)
                .background(Color(.blue))
                .onAppear{
                    //Here the Transaction in future logic should be added!
                }
            
        }
    }
}

