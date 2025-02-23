//
//  UILabel+attributedString.swift
//  MentoringProject
//
//  Created by PKW on 2/23/25.
//

import UIKit

extension UILabel {
    func setStyledText(text: String,
                       font: UIFont,
                       letterSpacing: CGFloat,
                       textAlignment: NSTextAlignment = .center)
    {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .kern: letterSpacing
        ]

        self.attributedText = NSAttributedString(string: text, attributes: attributes)
        self.textAlignment = textAlignment
    }
}
