//
//  UITextField+.swift
//  YDUI
//
//  Created by 류연수 on 12/14/24.
//

import UIKit

public extension UITextField {
    
    func setPlaceholder(_ placeholder: String, color placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
}
