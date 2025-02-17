//
//  UIScreen+size.swift
//  YDUI
//
//  Created by 류연수 on 12/30/24.
//

import UIKit

public extension UIScreen {
    
    static var height: CGFloat {
        UIScreen.main.bounds.height
    }
    
    static var width: CGFloat {
        UIScreen.main.bounds.width
    }
    
    static var contentsHeight: CGFloat {
        height - safeAreaHeight
    }
    
    static var safeAreaHeight: CGFloat {
        safeAreaTopHeight + safeAreaBottomHeight
    }
    
    static var safeAreaTopHeight: CGFloat {
        UIApplication.keyWindow?.safeAreaInsets.top ?? 0
    }
    
    static var safeAreaBottomHeight: CGFloat {
        UIApplication.keyWindow?.safeAreaInsets.bottom ?? 0
    }
}

public extension UIApplication {
    
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}
