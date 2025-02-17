//
//  UIViewController+keyboard.swift
//  YDFirebase
//
//  Created by wi_seong on 12/12/24.
//

import UIKit

extension UIViewController {
    public func setHideKeyBoardWhenTappedScreen() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func tapHandler() {
        self.view.endEditing(true)
    }
}
