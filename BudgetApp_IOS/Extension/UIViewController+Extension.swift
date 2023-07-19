////
////  UIViewController+Extension.swift
////  BudgetApp_IOS
////
////  Created by Enigma Kod on 17/07/2023.
////
//
import Foundation

#if canImport(swiftUI) && DEBUG
import SwiftUI

struct ViewControllerRepresentable: UIViewControllerRepresentable {
    let viewController: ViewController

    public init(_ builder: @escaping () -> ViewController) {
        viewController = builder()
    }

    public func makeUIViewController(context: Context) -> ViewController {
        viewController
    }

    public func updateUIViewController(_ uiViewController: ViewController, context: Context) {}
}

var persistenceContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "BudgetModel")
    container.loadPersistentStores { _, error in
        if let error = error { fatalError("Unable to load presistance container: \(error)") }
    }

    return container
}()

@available(iOS 13, *)
struct ViewController_Preview: PreviewProvider {
    let viewController: ViewController

    static var previews: some View {
        ViewControllerRepresentable(AddBudgetCategoryViewController(persistantContainer: persistenceContainer))
    }
}

//// MARK: - UIViewController extensions
//
// extension UIViewController {
//    @available(iOS 13, *)
//    private struct Preview: UIViewControllerRepresentable {
//        var viewController: UIViewController
//
//        func makeUIViewController(context: Context) -> UIViewController {
//            viewController
//        }
//
//        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//    }
//
//    @available(iOS 13, *)
//    func asPreview() -> some View {
//        Preview(viewController: self)
//    }
// }
//
//// MARK: - UIView Extensions
//
// extension UIView {
//    @available(iOS 13, *)
//    private struct Preview: UIViewRepresentable {
//        var view: UIView
//
//        func makeUIView(context: Context) -> UIView {
//            view
//        }
//
//        func updateUIView(_ view: UIView, context: Context) {}
//    }
//
//    @available(iOS 13, *)
//    func asPreview() -> some View {
//        Preview(view: self)
//    }
// }
//
#endif
