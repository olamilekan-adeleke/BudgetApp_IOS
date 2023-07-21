//
//  Double+Extenstion.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 21/07/2023.
//

import Foundation

extension Double {
    func formatToCurrency() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current

        let formattedString = currencyFormatter.string(from: NSNumber(value: self)) ?? "N/A"
        return formattedString
    }
}
