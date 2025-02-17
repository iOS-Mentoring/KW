//
//  UIColor+named.swift
//  YDUI
//
//  Created by 류연수 on 12/14/24.
//

import UIKit

extension UIColor {
    static let primaryEmphasis: UIColor = UIColor(named: "primary_emphasis") ?? UIColor.black
    static let inversePrimaryEmphasis: UIColor = UIColor(named: "inverse_primary_emphasis") ?? UIColor.black
    static let primaryRed: UIColor = UIColor(named: "primary_red") ?? UIColor.black

    static let gray300: UIColor = UIColor(named: "gray300") ?? UIColor.black
    static let gray200: UIColor = UIColor(named: "gray200") ?? UIColor.black
    static let gray100: UIColor = UIColor(named: "gray100") ?? UIColor.black
}

extension CGColor {
    static let primaryEmphasis: CGColor = UIColor.primaryEmphasis.cgColor
    static let inversePrimaryEmphasis: CGColor = UIColor.inversePrimaryEmphasis.cgColor
    static let primaryRed: CGColor = UIColor.primaryRed.cgColor

    static let gray300: CGColor = UIColor.gray300.cgColor
    static let gray200: CGColor = UIColor.gray200.cgColor
    static let gray100: CGColor = UIColor.gray100.cgColor
}
