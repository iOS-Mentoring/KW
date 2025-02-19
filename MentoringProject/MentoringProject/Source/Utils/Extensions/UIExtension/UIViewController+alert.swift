//
//  UIViewController+alert.swift
//  YDUI
//
//  Created by wi_seong on 12/20/24.
//

import UIKit

public extension UIViewController {
    
    @discardableResult
    func alert(
        title: String? = nil,
        message: String? = nil,
        preferredStyle: UIAlertController.Style = .alert,
        actions: [UIAlertAction]?,
        textFieldHandlers: [((UITextField) -> Void)]? = nil,
        completion: (() -> Void)? = nil
    ) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let actions = actions {
            actions.forEach({ (action) in
                alert.addAction(action)
            })
        }
        if let textFieldHandlers = textFieldHandlers {
            textFieldHandlers.forEach { (handler) in
                alert.addTextField(configurationHandler: handler)
            }
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: completion)
        }
        return alert
    }
}
