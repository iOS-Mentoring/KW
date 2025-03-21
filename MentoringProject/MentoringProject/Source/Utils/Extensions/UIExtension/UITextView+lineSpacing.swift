//
//  UITextView+lineSpacing.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

extension UITextView {
    func setLineSpacing(_ spacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing

        let attributedText = NSAttributedString(
            string: self.text ?? "",
            attributes: [
                .paragraphStyle: paragraphStyle,
                .font: self.font ?? UIFont.systemFont(ofSize: 16),
                .foregroundColor: UIColor.gray300
            ]
        )

        self.attributedText = attributedText
    }
}
