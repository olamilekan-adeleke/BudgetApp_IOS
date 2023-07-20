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
}
