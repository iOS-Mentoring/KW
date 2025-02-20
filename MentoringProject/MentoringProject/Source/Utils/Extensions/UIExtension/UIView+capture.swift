//
//  UIView+capture.swift
//  MentoringProject
//
//  Created by PKW on 2/19/25.
//

import UIKit

extension UIView {
    func captureImage() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        return renderer.image { context in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
    }
}
