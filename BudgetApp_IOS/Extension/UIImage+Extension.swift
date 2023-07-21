//
//  UIImage+Extension.swift
//  BudgetApp_IOS
//
//  Created by Enigma Kod on 19/07/2023.
//

import Foundation
import UIKit

extension UIImage {
    func with(_ insets: UIEdgeInsets) -> UIImage {
        let targetWidth = size.width + insets.left + insets.right
        let targetHeight = size.height + insets.top + insets.bottom
        let targetSize = CGSize(width: targetWidth, height: targetHeight)
        let targetOrigin = CGPoint(x: insets.left, y: insets.top)
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        let renderer = UIGraphicsImageRenderer(size: targetSize, format: format)
        return renderer.image { _ in
            draw(in: CGRect(origin: targetOrigin, size: size))
        }.withRenderingMode(renderingMode)
    }
}

func iconHelper(_ systemName: String) -> UIView {
    let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    var image = UIImage(systemName: systemName)?.with(insets)
    image = image!.withTintColor(UIColor.gray)
    let imageView = UIImageView(image: image)
    return imageView
}
