//
//  ViewController.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 17/07/2023.
//

import CoreData
import UIKit

class BudgetCategoryTableViewController: UIViewController {
    private var presistentContainer: NSPersistentContainer

    init(presistentContainer: NSPersistentContainer) {
        self.presistentContainer = presistentContainer
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()
    }

    @objc private func showAddBudgetCategory(_ sender: UIBarButtonItem) {
        let rootController = AddBudgetCategoryViewController(persistantContainer: presistentContainer)
        let navController = UINavigationController(rootViewController: rootController)
        present(navController, animated: true)
    }

    private func setUpUI() {
        let addBudgetCategoryButton = UIBarButtonItem(
            title: "Add Category", style: .done, target: self, action: #selector(showAddBudgetCategory)
        )
        addBudgetCategoryButton.tintColor = .systemTeal

        navigationItem.rightBarButtonItem = addBudgetCategoryButton
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "My Budget"
    }
}
