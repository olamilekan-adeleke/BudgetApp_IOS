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
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Budget Name"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Budget Amount"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var addBudgetButton: UIButton = {
        let button = UIButton(configuration: .bordered())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save Budget", for: .normal)
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
        stack.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stack.backgroundColor = .gray
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
        
        // constarins
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: view.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            nameTextField.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.90),
            amountTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.90),
        ])
        
        // button
        addBudgetButton.addTarget(self, action: #selector(addButtomPressed), for: .touchUpInside)
    }
    
    @objc private func addButtomPressed(_ sender: UIButton) {}
}

// MARK: - Preview

// #if canImport(swiftUI) && DEBUG
// import SwiftUI
// @available(iOS 13.0, *)
// struct AddBudgetCategoryViewControllerPreview: PreviewProvider {
//
//
//    static var previews: some View {
//        UINavigationController(rootViewController: AddBudgetCategoryViewController(persistantContainer: persistenceContainer)).preview
//    }
// }
// #endif

var persistenceContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "BudgetModel")
    container.loadPersistentStores { _, error in
        if let error = error { fatalError("Unable to load presistance container: \(error)") }
    }
    
    return container
}()

#if canImport(swiftUI) && DEBUG
import SwiftUI
@available(iOS 13, *)
struct MyViewControllerPreview: PreviewProvider {
    static var previews: some View {
        AddBudgetCategoryViewController(persistantContainer: persistenceContainer).asPreview()
    }
}

// @available(iOS 13.0, *)
// struct ViewControllerExamplePreview: PreviewProvider {
//    static var previews: some View {
//        ViewControllerPreview {
//            AddBudgetCategoryViewController(persistantContainer: persistenceContainer)
//        }
//    }
// }

#endif
