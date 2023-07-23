//
//  ViewController.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 17/07/2023.
//

import CoreData
import UIKit

class BudgetCategoryTableViewController: UITableViewController {
    private var fetchedResultController: NSFetchedResultsController<BudgetCategory>!
    private var presistentContainer: NSPersistentContainer

    init(presistentContainer: NSPersistentContainer) {
        self.presistentContainer = presistentContainer
        super.init(nibName: nil, bundle: nil)

        let fetchRequest = BudgetCategory.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        self.fetchedResultController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: presistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultController.delegate = self

        do {
            try fetchedResultController.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpUI()

        // register TableView Cell
        tableView.register(BudgetTableViewCell.self, forCellReuseIdentifier: "BudgetTableViewCell")
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

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (fetchedResultController.fetchedObjects ?? []).count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let budgetCategory = fetchedResultController.object(at: indexPath)
        navigationController?.pushViewController(
            BudgetDetailViewController(presistentContainer: presistentContainer, budgetCategory: budgetCategory),
            animated: true
        )
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BudgetTableViewCell", for: indexPath) as? BudgetTableViewCell else {
            return BudgetTableViewCell(style: .default, reuseIdentifier: "BudgetTableViewCell")
        }

        let budgetCategory = fetchedResultController.object(at: indexPath)
        cell.accessoryType = .disclosureIndicator
        cell.config(budgetCategory)

        return cell
    }
}

extension BudgetCategoryTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        let range = NSMakeRange(0, tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        tableView.reloadSections(sections as IndexSet, with: .automatic)
    }
}
