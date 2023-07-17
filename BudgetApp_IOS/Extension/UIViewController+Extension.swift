//
//  UIViewController+Extension.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 17/07/2023.
//

import Foundation

#if canImport(swiftUI) && DEBUG
import SwiftUI
// @available(iOS 13.0, *)
// public struct ViewControllerPreview<ViewController: UIViewController>: UIViewControllerRepresentable {
//    let viewController: ViewController
//
//    public init(_ builder: @escaping () -> ViewController) {
//        viewController = builder()
//    }
//
//    public func makeUIViewController(context: Context) -> ViewController {
//        viewController
//    }
//
//    public func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
// }

// MARK: - UIViewController extensions

extension UIViewController {
    @available(iOS 13, *)
    private struct Preview: UIViewControllerRepresentable {
        var viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }

    @available(iOS 13, *)
    func asPreview() -> some View {
        Preview(viewController: self)
    }
}

// MARK: - UIView Extensions

extension UIView {
    @available(iOS 13, *)
    private struct Preview: UIViewRepresentable {
        var view: UIView

        func makeUIView(context: Context) -> UIView {
            view
        }

        func updateUIView(_ view: UIView, context: Context) {}
    }

    @available(iOS 13, *)
    func asPreview() -> some View {
        Preview(view: self)
    }
}

#endif
