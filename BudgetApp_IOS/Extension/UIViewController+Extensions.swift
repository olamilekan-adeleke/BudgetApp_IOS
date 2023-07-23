//
//  UIViewController+Extensions.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 23/07/2023.
//

import Foundation
import UIKit

public extension UIViewController {
    func showAlert(title: String, messsage: String) {
        let alert = UIAlertController(title: title, message: messsage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alert, animated: true)
    }
}
