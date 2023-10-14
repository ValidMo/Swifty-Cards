//
//  TransactionInFuture+CoreDataProperties.swift
//  Cards
//
//  Created by Valid Mohammadi on 19.09.2023.
//
//

import Foundation
import CoreData


extension TransactionInFuture {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionInFuture> {
        return NSFetchRequest<TransactionInFuture>(entityName: "TransactionInFuture")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var desc: String?
    @NSManaged public var id: UUID
    @NSManaged public var notificationStatus: Bool
    @NSManaged public var transactionInFutureToCard: Card

}

extension TransactionInFuture : Identifiable {

}
