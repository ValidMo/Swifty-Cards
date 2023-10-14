//
//  Card+CoreDataProperties.swift
//  Cards
//
//  Created by Valid Mohammadi on 19.09.2023.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var bookmarkStatus: Bool
    @NSManaged public var iban: String?
    @NSManaged public var id: UUID
    @NSManaged public var money: Double
    @NSManaged public var name: String
    @NSManaged public var number: String
    @NSManaged public var cardToTransaction: NSSet?
    @NSManaged public var cardToTransactionInFuture: NSSet?
    @NSManaged public var alpha: Float
    @NSManaged public var red: Float
    @NSManaged public var green: Float
    @NSManaged public var blue: Float
  

}

// MARK: Generated accessors for cardToTransaction
extension Card {

    @objc(addCardToTransactionObject:)
    @NSManaged public func addToCardToTransaction(_ value: Transaction)

    @objc(removeCardToTransactionObject:)
    @NSManaged public func removeFromCardToTransaction(_ value: Transaction)

    @objc(addCardToTransaction:)
    @NSManaged public func addToCardToTransaction(_ values: NSSet)

    @objc(removeCardToTransaction:)
    @NSManaged public func removeFromCardToTransaction(_ values: NSSet)

}

// MARK: Generated accessors for cardToTransactionInFuture
extension Card {

    @objc(addCardToTransactionInFutureObject:)
    @NSManaged public func addToCardToTransactionInFuture(_ value: TransactionInFuture)

    @objc(removeCardToTransactionInFutureObject:)
    @NSManaged public func removeFromCardToTransactionInFuture(_ value: TransactionInFuture)

    @objc(addCardToTransactionInFuture:)
    @NSManaged public func addToCardToTransactionInFuture(_ values: NSSet)

    @objc(removeCardToTransactionInFuture:)
    @NSManaged public func removeFromCardToTransactionInFuture(_ values: NSSet)

}

extension Card : Identifiable {

}
