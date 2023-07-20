//
//  UITextField+Extension.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 19/07/2023.
//

import Foundation
import UIKit

@available(iOS 14.0, *)
extension UITextField {
    func setOnTextChangeListener(onTextChanged: @escaping () -> Void) {
        self.addAction(UIAction { _ in onTextChanged() }, for: .editingChanged)
    }
}
