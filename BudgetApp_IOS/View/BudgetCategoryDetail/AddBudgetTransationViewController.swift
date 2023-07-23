//
//  AddBudgetTransationViewController.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 22/07/2023.
//

import Foundation
import UIKit

class AddBudgetTransactionViewController: UIViewController {
    private var budgetManager: BudgetManager
    private var budgetCategory: BudgetCategory
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Transations"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter the details of your transation below."
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Transaction Name"
        textField.leftView = iconHelper("text.book.closed")
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Transaction Amount"
        textField.leftView = iconHelper("nairasign")
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var addSaveButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save Transaction", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemTeal
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(saveTrans), for: .touchUpInside)
        return button
    }()
    
    lazy var erroMessage: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = label.font.withSize(12)
        label.text = ""
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    
    private func isFormValid() -> Bool {
        guard let name = nameTextField.text, let amount = amountTextField.text else { return false }

        return !name.isEmpty == true && !amount.isEmpty && Double(amount) != nil
    }

    @objc private func saveTrans(_ sender: UIButton) {
        if isFormValid() {
            guard let name = nameTextField.text, let amount = Double(amountTextField.text!) else { return }

            budgetManager.saveTransaction(name: name, amount: amount, budgetCategory: budgetCategory)
            dismiss(animated: true)
        } else {
            erroMessage.text = "Invalid Details, Make sure name and amount is valid"
        }
    }
    
    init(budgetManager: BudgetManager, budgetCategory: BudgetCategory) {
        self.budgetManager = budgetManager
        self.budgetCategory = budgetCategory
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        title = "Add Transactions"
        
        setUpUI()
    }
    
    private func setUpUI() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.setCustomSpacing(20, after: subtitleLabel)
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(amountTextField)
        stackView.setCustomSpacing(15, after: nameTextField)
        stackView.setCustomSpacing(40, after: amountTextField)
        
        stackView.addArrangedSubview(addSaveButton)
        stackView.setCustomSpacing(10, after: addSaveButton)
        
        stackView.addArrangedSubview(erroMessage)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor),
            subtitleLabel.leadingAnchor.constraint(equalTo: stackView.safeAreaLayoutGuide.leadingAnchor),
        
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            amountTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            addSaveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
    }
}
