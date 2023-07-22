//
//  AddBudgetTransationViewController.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 22/07/2023.
//

import Foundation
import UIKit

class AddBudgetTransactionViewController: UIViewController {
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
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        stack.spacing = UIStackView.spacingUseSystem
        return stack
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        setUpUI()
    }
    
    private func setUpUI() {
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(amountTextField)
        stackView.setCustomSpacing(40, after: amountTextField)
        
        stackView.addArrangedSubview(addSaveButton)
        stackView.setCustomSpacing(10, after: addSaveButton)
        
        stackView.addArrangedSubview(erroMessage)
    }
}
