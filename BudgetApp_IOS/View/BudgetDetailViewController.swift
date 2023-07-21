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
    private var budgetCategory: BudgetCategory

    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Transaction Name"
        textField.leftView = iconHelper("text.book.closed")
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        return textField
    }()

    lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Transaction Amount"
        textField.leftView = iconHelper("nairasign")
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        return textField
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCell")
        return tableView
    }()

    lazy var addSaveButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save Transaction", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemTeal
        return button
    }()

    lazy var erroMessage: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = label.font.withSize(12)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()

    init(presistentContainer: NSPersistentContainer, budgetCategory: BudgetCategory) {
        self.presistentContainer = presistentContainer
        self.budgetCategory = budgetCategory
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    private func setUpUI() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = budgetCategory.name
    }
}

extension BudgetDetailViewController: UITableViewDelegate {}

extension BudgetDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionTableViewCell", for: indexPath)
        return cell
    }
}
