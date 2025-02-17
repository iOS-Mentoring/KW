//
//  UIImageView+animation.swift
//  YDUI
//
//  Created by wi_seong on 1/3/25.
//

import UIKit

public extension UIImageView {

    func makeAnimation(images: [UIImage], repeatCount: Int = 1, frame: Double = 18.0) {
        self.animationImages = images
        self.animationDuration = Double(images.count) / frame
        self.animationRepeatCount = repeatCount
    }
}
