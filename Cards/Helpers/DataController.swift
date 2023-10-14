
import Foundation
import CoreData
import SwiftUI

class DataController: ObservableObject {
    
    let containter: NSPersistentContainer = NSPersistentContainer(name: "Model")
    
    init(){
        containter.loadPersistentStores{
            desc, error in
            if let error = error {
                print("Error while loading data: \(error.localizedDescription)")
            }
        }
        
        ValueTransformer.setValueTransformer(NSColorTransformer(), forName: NSValueTransformerName("NSColorTransformer"))
    }
    
    func save(context: NSManagedObjectContext){
        do {
            try context.save()
            print("Data successfully saved ")
        }
        catch {
            print("Error while saving data")
        }
    }
    
    func addCard(name: String, number: String, iban: String, money: Double, bookmarkStatus: Bool, color: Color, context: NSManagedObjectContext){
        let card: Card = Card(context: context)
        card.id = UUID()
        card.name = name
        card.number = number
        card.iban = iban
        card.money = money
        card.bookmarkStatus = bookmarkStatus
       
        let theColor = UIColor(color)
        card.red = Float(theColor.components.red)
        card.green = Float(theColor.components.green)
        card.blue = Float(theColor.components.blue)
        card.alpha = Float(theColor.components.alpha)
        
        save(context: context)
        
    }
    
    func editCard(card: Card, name: String, number: String, iban: String, money: Double, color: Color,  context: NSManagedObjectContext){
        card.name = name
        card.number = number
        card.iban = iban
        card.money = money

        let theColor = UIColor(color)
        card.red = Float(theColor.components.red)
        card.green = Float(theColor.components.green)
        card.blue = Float(theColor.components.blue)
        card.alpha = Float(theColor.components.alpha)
        
        save(context: context)
    }
    
    func addTransaction(card: Card, date: Date, amount: Double, desc: String, notificationStatus: Bool, context: NSManagedObjectContext){
        let Transaction: Transaction = Transaction(context: context)
        Transaction.id = UUID()
        Transaction.date = date
        Transaction.amount = amount
        Transaction.desc = desc
        Transaction.notificationStatus = notificationStatus
        Transaction.transactionToCard = card
        
        //we should add future transaction logic
        
        save(context: context)
    }
    
    func editTransaction(Transaction: Transaction, date: Date, amount: Double, desc: String, notificationStatus: Bool, context: NSManagedObjectContext){
        Transaction.date = date
        Transaction.amount = amount
        Transaction.desc = desc
        Transaction.notificationStatus = notificationStatus
        
        //we should add future transaction logic
        
        
        
        save(context: context)
    }
    
    
    func deleteCard(card: Card, context: NSManagedObjectContext){
        
        if let transactions = card.cardToTransaction as? Set<Transaction> {
            for transaction in transactions {
                context.delete(transaction)
            }
        }
        
        if let transactions = card.cardToTransactionInFuture as? Set<TransactionInFuture>
        {
            for transaction in transactions {
                context.delete(transaction)
            }
        }
        context.delete(card)
        save(context: context)
    }
    
    func addTransactionInFuture(card: Card, date: Date, amount: Double, desc: String, notificationStatus: Bool, context: NSManagedObjectContext){
        let transactionInFuture = TransactionInFuture(context: context)
        
        transactionInFuture.id = UUID()
        transactionInFuture.transactionInFutureToCard = card
        transactionInFuture.date = date
        transactionInFuture.amount = amount
        transactionInFuture.desc = desc
        transactionInFuture.notificationStatus = notificationStatus
        
        save(context: context)
        
    }
    
    
    func deleteTransaction(transaction: Transaction, context: NSManagedObjectContext) -> () {
        withAnimation {
            transaction.transactionToCard?.money += transaction.amount
            context.delete(transaction)
            save(context: context)
        }
    }
    
    
    func deleteTransactionInFuture(transactionInFuture: TransactionInFuture, context: NSManagedObjectContext) -> (){
        withAnimation {
            

            context.delete(transactionInFuture)
            save(context: context)
        }
    }
    
 
}
