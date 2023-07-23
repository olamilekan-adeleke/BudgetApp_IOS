//
//  BudgetDetailViewController.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 21/07/2023.
//

import CoreData
import Foundation
import UIKit

class BudgetDetailViewController: UIViewController {
    private var presistentContainer: NSPersistentContainer
    private var fetchedResultController: NSFetchedResultsController<Transactions>!
    private var budgetCategory: BudgetCategory
    private var budgetManager: BudgetManager

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return stack
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()

    private lazy var containerLabel: UILabel = {
        let label = UILabel()
        label.text = "Tap To Add Transations"
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var container: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addTransTap))
        view.addGestureRecognizer(tapGesture)
        return view
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = budgetCategory.amount.formatToCurrency()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var transactionTotal: UILabel = {
        let label = UILabel()
        label.textColor = .systemTeal
        label.font = label.font.withSize(12)
        label.text = ""
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func updateTotalTransaction() {
        transactionTotal.text = "Transaction Total: " + budgetCategory.transactionTotal.formatToCurrency()
    }

    init(presistentContainer: NSPersistentContainer, budgetCategory: BudgetCategory) {
        self.presistentContainer = presistentContainer
        self.budgetCategory = budgetCategory
        self.budgetManager = BudgetManager(persistantContainerManager: presistentContainer.viewContext)
        
        super.init(nibName: nil, bundle: nil)

        let fetchRequest = Transactions.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "category = %@", budgetCategory)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]

        self.fetchedResultController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: presistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        fetchedResultController.delegate = self

        do {
            try fetchedResultController.performFetch()
        } catch {}
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func addTransTap() {
        let budgetManger = BudgetManager(persistantContainerManager: presistentContainer.viewContext)
        let addBudgetTransactionCV = AddBudgetTransactionViewController(budgetManager: budgetManger, budgetCategory: budgetCategory)
        addBudgetTransactionCV.modalPresentationStyle = .pageSheet
        if let sheet = addBudgetTransactionCV.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.detents = [.custom { _ in 300 }]
            present(addBudgetTransactionCV, animated: true)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = .systemTeal
        title = budgetCategory.name

        setUpUI()
        updateTotalTransaction()
    }

    private func setUpUI() {
        container.addSubview(containerLabel)

        stackView.addArrangedSubview(amountLabel)
        stackView.setCustomSpacing(10, after: amountLabel)
        stackView.addArrangedSubview(container)
        stackView.setCustomSpacing(20, after: container)

        stackView.addArrangedSubview(transactionTotal)
        stackView.setCustomSpacing(5, after: transactionTotal)
        stackView.addArrangedSubview(tableView)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            container.heightAnchor.constraint(equalToConstant: 50),

            containerLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            containerLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),

            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension BudgetDetailViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        let range = NSMakeRange(0, tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        tableView.reloadSections(sections as IndexSet, with: .automatic)
        updateTotalTransaction()
    }
}

extension BudgetDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let transaction = fetchedResultController.object(at: indexPath)
            budgetManager.deleteTransaction(transaction: transaction)
        }
    }
}

extension BudgetDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (fetchedResultController.fetchedObjects ?? []).count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath)
        let transaction = fetchedResultController.object(at: indexPath)

        var config = cell.defaultContentConfiguration()
        config.text = transaction.name
        config.secondaryText = transaction.amount.formatToCurrency()
        cell.contentConfiguration = config

        return cell
    }
}
