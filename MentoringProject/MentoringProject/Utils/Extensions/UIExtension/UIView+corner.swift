//
//  UIView+corner.swift
//  YDCalendar
//
//  Created by wi_seong on 12/19/24.
//

import UIKit

public extension UIView {
    func roundCorners(cornerRadius: CGFloat, maskedCorners: CACornerMask) {
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = CACornerMask(arrayLiteral: maskedCorners)
    }
}
