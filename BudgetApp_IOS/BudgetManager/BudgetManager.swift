//
//  BudgetManager.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 20/07/2023.
//

import CoreData
import Foundation

class BudgetManager {
    let persistantContainerManager: NSManagedObjectContext

    init(persistantContainerManager: NSManagedObjectContext) {
        self.persistantContainerManager = persistantContainerManager
    }

    func saveBudget(name: String, amount: Double) {
        do {
            let budgetCategory = BudgetCategory(context: persistantContainerManager)

            budgetCategory.name = name
            budgetCategory.amount = amount
            try persistantContainerManager.save()
        } catch {
            print("Unable To save budget category")
        }
    }

    public func saveTransaction(name: String, amount: Double, budgetCategory: BudgetCategory) {
        do {
            let transation = Transactions(context: persistantContainerManager)
            transation.name = name
            transation.amount = amount
            transation.dateCreated = Date()
            transation.category = budgetCategory

            budgetCategory.addToTransactions(transation)
            try persistantContainerManager.save()

        } catch {
            print("Unable To save budget transaction")
        }
    }

    public func deleteTransaction(transaction: Transactions) {
        do {
            persistantContainerManager.delete(transaction)
            try persistantContainerManager.save()

        } catch {
            print("Unable To delete budget transaction")
        }
    }
    
    public func deleteBudgetCategory(budegtCategory: BudgetCategory) {
        do {
            persistantContainerManager.delete(budegtCategory)
            try persistantContainerManager.save()
            
        } catch {
            print("Unable To delete budget transaction")
        }
    }
}
