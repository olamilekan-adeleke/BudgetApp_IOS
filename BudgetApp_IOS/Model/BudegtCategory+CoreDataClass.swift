//
//  BudegtCategory+CoreDataClass.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 23/07/2023.
//

import CoreData
import Foundation

@objc(BudgetCategory)
public class BudgetCategory: NSManagedObject {
    var transactionTotal: Double {
        let transactionsArray: [Transactions] = self.transactions?.toArray() ?? []
        return transactionsArray.reduce(0) { next, transaction in
            next + transaction.amount
        }
    }

    var remainingAmount: Double { return amount - self.transactionTotal }
}

extension NSSet {
    func toArray<T>() -> [T] {
        return self.map { $0 as! T }
    }
}
