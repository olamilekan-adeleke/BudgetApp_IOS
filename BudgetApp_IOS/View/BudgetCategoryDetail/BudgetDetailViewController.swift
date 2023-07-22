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

    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TransactionTableViewCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
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

    init(presistentContainer: NSPersistentContainer, budgetCategory: BudgetCategory) {
        self.presistentContainer = presistentContainer
        self.budgetCategory = budgetCategory
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func addTransTap() {
        let addBudgetTransactionCV = AddBudgetTransactionViewController()
        addBudgetTransactionCV.modalPresentationStyle = .pageSheet
        if let sheet = addBudgetTransactionCV.sheetPresentationController {
            sheet.prefersGrabberVisible = true
            sheet.detents = [
                .custom { _ in 200 },
                .custom { context in context.maximumDetentValue * 0.6 },
            ]
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
    }

    private func setUpUI() {
        container.addSubview(containerLabel)

        stackView.addArrangedSubview(container)
        stackView.setCustomSpacing(40, after: container)

//        stackView.addArrangedSubview(tableView)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            container.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            container.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            container.heightAnchor.constraint(equalToConstant: 50),

            containerLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            containerLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor),
        ])
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
