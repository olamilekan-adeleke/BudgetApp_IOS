//
//  AddBudgetCategoryViewController.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 17/07/2023.
//

import CoreData
import Foundation
import UIKit

class AddBudgetCategoryViewController: UIViewController {
    private var persistantContainer: NSPersistentContainer
    private let budgetManager: BudgetManager
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Budget Name"
        textField.leftView = iconHelper("text.book.closed")
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Budget Amount"
        textField.leftView = iconHelper("nairasign")
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var addBudgetButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save Budget", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray, for: .highlighted)
        button.backgroundColor = .systemTeal
        
        return button
    }()
    
    lazy var nameErroMessage: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = label.font.withSize(12)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    lazy var amountErroMessage: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = label.font.withSize(12)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: -20)
        return stack
    }()
    
    init(persistantContainer: NSPersistentContainer) {
        self.persistantContainer = persistantContainer
        self.budgetManager = BudgetManager(persistantContainerManager: persistantContainer.viewContext)
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
    
    private func setUpUI() {
        title = "Add Budget"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(nameErroMessage)
        stackView.addArrangedSubview(amountTextField)
        stackView.addArrangedSubview(amountErroMessage)
        stackView.addArrangedSubview(addBudgetButton)
        
        nameTextField.setOnTextChangeListener { self.nameDidChange() }
        amountTextField.setOnTextChangeListener { self.amountDidChange() }
        
        // constarins
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            amountTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            addBudgetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
        
        stackView.setCustomSpacing(15, after: nameErroMessage)
        stackView.setCustomSpacing(50, after: amountErroMessage)
        
        // button
        addBudgetButton.addTarget(self, action: #selector(addButtomPressed), for: .touchUpInside)
    }
    
    private func isFormValid() -> Bool {
        guard let name = nameErroMessage.text, let amount = amountErroMessage.text else { return false }
        
        return name.isEmpty == true && amount.isEmpty == true
    }
    
    @objc private func addButtomPressed(_ sender: UIButton) {
        guard let name = nameTextField.text, let amount = amountTextField.text else { return }
        
        if isFormValid() {
            budgetManager.saveBudget(name: name, amount: Double(amount) ?? 0)
            dismiss(animated: true)
        }
    }
    
    private func nameDidChange() {
        if nameTextField.text == nil || nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty != false {
            nameErroMessage.text = "Budget name is required."
        } else {
            nameErroMessage.text = ""
        }
    }
    
    private func amountDidChange() {
        guard let amount = amountTextField.text else {
            amountErroMessage.text = "Budget amount is required."
            return
        }
        
        if amountTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty != false {
            amountErroMessage.text = "Budget amount is required."
            return
        }
        
        if amount.isEmpty || Double(amount) == nil || (Double(amount) ?? 0) <= 0 {
            amountErroMessage.text = "Budget amount must be a vaild number greater than 0"
        } else {
            amountErroMessage.text = ""
        }
    }
}
