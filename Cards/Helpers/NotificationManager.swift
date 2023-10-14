

import Foundation
import UserNotifications

class NotificationManager {
    
    static let notificationManager = NotificationManager()  //Singleton
    
    func requestAutorization() {
        
        
        let notificationOptions: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: notificationOptions) { success, error in
            if let error = error {
                print(error.localizedDescription)
            }
            else {
                print("Success!")
            }
        }
    }
    
    func cancelNotifications(){
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
    }
    
}
