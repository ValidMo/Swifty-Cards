//
//  Transaction+CoreDataProperties.swift
//  Cards
//
//  Created by Valid Mohammadi on 19.09.2023.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date
    @NSManaged public var desc: String
    @NSManaged public var id: UUID
    @NSManaged public var notificationStatus: Bool
    @NSManaged public var transactionToCard: Card?

}

extension Transaction : Identifiable {

}
