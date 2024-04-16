

import SwiftUI

@main
struct CardsApp: App {
    
    let dataController: DataController = DataController()
    
    @AppStorage("isDarkMode") private var darkModeStatus: Bool = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.containter.viewContext)
                .background(Color(.blue))
                .onAppear{
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                    let window = windowScene.windows.first

                    UserDefaults.standard.set(darkModeStatus, forKey: "darkModeEnabled")
                    if darkModeStatus {
                        window?.overrideUserInterfaceStyle = .dark
                    } else {
                        window?.overrideUserInterfaceStyle = .light
                    }

                }
            
        }
    }
}

