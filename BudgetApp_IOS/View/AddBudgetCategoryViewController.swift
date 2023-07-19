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
    
    private func iconHelper(_ systemName: String) -> UIView {
        let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        var image = UIImage(systemName: systemName)?.with(insets)
        image = image!.withTintColor(UIColor.gray)
        let imageView = UIImageView(image: image)
        return imageView
    }
    
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
    
    lazy var erroMessage: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.spacing = UIStackView.spacingUseSystem
        stack.isLayoutMarginsRelativeArrangement = true
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: -20)
        return stack
    }()
    
    init(persistantContainer: NSPersistentContainer) {
        self.persistantContainer = persistantContainer
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
        stackView.addArrangedSubview(amountTextField)
        stackView.addArrangedSubview(addBudgetButton)
        stackView.addArrangedSubview(erroMessage)
        
        stackView.setCustomSpacing(10, after: nameTextField)
        stackView.setCustomSpacing(50, after: amountTextField)
        
        // constarins
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            amountTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            addBudgetButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
        ])
        
        // button
        addBudgetButton.addTarget(self, action: #selector(addButtomPressed), for: .touchUpInside)
    }
    
    @objc private func addButtomPressed(_ sender: UIButton) {}
}
