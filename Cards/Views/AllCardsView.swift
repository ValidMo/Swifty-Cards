
import SwiftUI
import CoreData
import UIKit

struct AllCardsView: View {
    
 
    
    
    //MARK: - Properties
    @FetchRequest(sortDescriptors: []) var cards: FetchedResults<Card>
    @FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "bookmarkStatus == true")) private var bookmarked: FetchedResults<Card>
    
    @Environment(\.managedObjectContext) var managedObjectContext

    @Binding var TransactionDoneNotification: Bool
    @Binding var AccountEditedNotification: Bool
    @Binding var AccountDeletedNotification: Bool
    @Binding var selectedTab: Int
   
//    private let pasteBoard = UIPasteboard.general check this
    
    
    //MARK: - The body
    var body: some View {
        
        
        NavigationView{
            ScrollView(.vertical, showsIndicators: false){
                ForEach(cards){ card in
                    NavigationLink {
                        CardDetailView(card: card,
                                       TransactionDoneNotification: $TransactionDoneNotification,
                                       AccountEditedNotification: $AccountEditedNotification,
                                       AccountDeletedNotification: $AccountDeletedNotification)
                        
                    } label: {
                        ZStack{
                            //MARK: - Card details
                            Rectangle()
                                .customRectangle()
                                .foregroundColor(Color(UIColor(red: CGFloat(card.red), green: CGFloat(card.green), blue: CGFloat(card.blue), alpha: CGFloat(card.alpha))))
                               
                            
                            VStack(spacing: 30){
                                Text(card.name)
                                    .customText()
                                
                                Text(card.number)
                                    .customText()
                                Text(card.iban ?? "")
                                    .font(.custom("Aldrich-Regular", size: 16))
                                    .foregroundColor(.white)
                                
                                let editedMoneyText = textCorrectorWithPoint(text: String(card.money))
                                
                                Text(String(editedMoneyText))
                                    .customText()
//                          ActivityView(activityItems: [pasteBoard.string ?? ""])
                                
                            }
                            //MARK: - Bookmark Button
                            Button {
                                let id: UUID = card.id
                                
                                let fetchReuqest = Card.fetchRequest()
                                fetchReuqest.predicate = NSPredicate(format: "bookmarkStatus == true")
                                
                                var bookmarkedArray = returnBookmarkedArray(context: managedObjectContext)
                                
                                
                                if (bookmarkedArray.count == 4 && bookmarkedArray.first != nil ){
                                    let cardToBeRemoved = bookmarkedArray.first //
                                    cardToBeRemoved?.bookmarkStatus.toggle()
                                    bookmarkedArray.removeFirst()
                                }
                                
                                if(card.bookmarkStatus){
                                    bookmarkedArray.removeAll{ card in card.id == id}
                                    card.bookmarkStatus.toggle()
                                }
                                else {
                                    bookmarkedArray.append(card)
                                    card.bookmarkStatus.toggle()
                                }
                                
                                
                                DataController().save(context: managedObjectContext)
                                
                                
                            } label: {
                                card.bookmarkStatus == true ? Image(systemName: "bookmark.fill") : Image(systemName: "bookmark")
                            }
                            .position(x:50, y:50)
                            .foregroundColor(.white)
                            
                        }
                        }

                    }
                }

                }
                            
            }
    
    //MARK: - Functions
    
    func returnBookmarkedArray(context: NSManagedObjectContext) -> [Card] {
        let fetchBookmarks = Card.fetchRequest()
        fetchBookmarks.predicate = NSPredicate(format: "bookmarkStatus == true")
        
        var bookmarksArray: [Card] = []
        
        do {
           bookmarksArray = try context.fetch(fetchBookmarks)
        }
        catch {
            print("Can not convert fetched results to array!")
        }
        
        return bookmarksArray
    }
        
}

    





    //MARK: - Extensions
extension Text {
    func customText() -> some View {
        return self
            .font(.custom("Aldrich-Regular", size: 25))
            .foregroundColor(.white)
    }
}

extension Button {
    func customButton() -> some View {
        return self
            .frame(width:55, height: 55)
            .background()
            .cornerRadius(15)
    }
}

extension Image {
    func customImage() -> some View {
        return self
            .resizable()
            .scaledToFit()
            .fontWeight(.bold)
    }
}

extension Rectangle {
    func customRectangle() -> some View{
        return self
            .frame(width: 360, height: 250)
          
            .cornerRadius(24)
            .padding()
    }
}
