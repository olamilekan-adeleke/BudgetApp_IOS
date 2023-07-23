//
//  BudgetTableViewCell.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 22/07/2023.
//

import Foundation
import SwiftUI
import UIKit

class BudgetTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = ""
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = ""
        label.alpha = 0.5
        return label
    }()

    lazy var trailingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .gray
        label.text = ""
        return label
    }()

    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 44)
        return stack
    }()

    lazy var hStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        stack.axis = .vertical
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpUI()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func config(_ budgetCategory: BudgetCategory) {
        titleLabel.text = budgetCategory.name
        subtitleLabel.text = budgetCategory.amount.formatToCurrency()
        trailingLabel.text = "Remaining: " + "NGN 50.00"
    }

    private func setUpUI() {
        hStackView.addArrangedSubview(titleLabel)
        hStackView.addArrangedSubview(subtitleLabel)

        stackView.addArrangedSubview(hStackView)
        stackView.addArrangedSubview(trailingLabel)

        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor),
        ])
    }
}

struct BudgetTableViewCellRepestable: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        BudgetTableViewCell(style: .default, reuseIdentifier: "BudgetTableViewCell")
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct BudgetTableViewCell_Preview: PreviewProvider {
    static var previews: some View {
        BudgetTableViewCellRepestable()
    }
}
