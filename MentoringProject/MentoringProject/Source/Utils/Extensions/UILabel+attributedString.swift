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
                       lineHeight: CGFloat,
                       letterSpacing: CGFloat,
                       textAlignment: NSTextAlignment = .center)
    {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = max(lineHeight, font.lineHeight)
        paragraphStyle.maximumLineHeight = max(lineHeight, font.lineHeight)
        
        let letterSpacing = letterSpacing * font.pointSize
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .kern: letterSpacing,
            .paragraphStyle: paragraphStyle
        ]

        self.attributedText = NSAttributedString(string: text, attributes: attributes)
        self.textAlignment = textAlignment
    }
}
