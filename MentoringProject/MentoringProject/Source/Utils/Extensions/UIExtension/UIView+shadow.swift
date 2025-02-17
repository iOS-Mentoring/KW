//
//  UIView+shadow.swift
//  YDUI
//
//  Created by wi_seong on 12/18/24.
//

import UIKit

public extension UIView {
    func addShadow(to edges: [UIRectEdge], radius: CGFloat = 2.0, opacity: Float = 0.2, color: CGColor = UIColor.black.cgColor) -> [CAGradientLayer] {
        let fromColor = color
        let toColor = UIColor.clear.cgColor
        let viewFrame = self.frame
        var gradientLayers = [CAGradientLayer]()

        for edge in edges {
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = [fromColor, toColor]
            gradientLayer.opacity = opacity

            switch edge {
            case .top:
                gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.25, y: 1.0)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: viewFrame.width, height: radius)
            case .bottom:
                gradientLayer.startPoint = CGPoint(x: 0.25, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 0.25, y: 0.0)
                gradientLayer.frame = CGRect(x: 0.0, y: viewFrame.height - radius, width: viewFrame.width, height: radius)
            case .left:
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.75)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.75)
                gradientLayer.frame = CGRect(x: 0.0, y: 0.0, width: radius, height: viewFrame.height)
            case .right:
                gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.75)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.75)
                gradientLayer.frame = CGRect(x: viewFrame.width - radius, y: 0.0, width: radius, height: viewFrame.height)
            default:
                break
            }
            self.layer.addSublayer(gradientLayer)
            gradientLayers.append(gradientLayer)
        }
        return gradientLayers
    }
}
