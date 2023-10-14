

import SwiftUI

enum Notification: String {
    case Transaction = "Transaction Done"
    case AccountAdded = "Card Added"
    case AccountEdited = "Card Edited"
    case AccountDeleted = "Card Deleted"
}

struct NotificationView: View {
    
    @State var notificationText: String

    
    var body: some View {
        Text(notificationText)
            .font(.custom("Aldrich-Regular", size: 20))
            .foregroundColor(.green)
            .frame(width: 330, height: 50)
            .background(Color(.white))
            .cornerRadius(30)
        
    }
}

