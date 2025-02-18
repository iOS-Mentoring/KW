//
//  UITextView+combine.swift
//  MentoringProject
//
//  Created by PKW on 2/18/25.
//

import Combine
import UIKit

extension UITextView {
    
    // 적용 안되는데 왜?
    var textPublisher1: AnyPublisher<String, Never> {
        publisher(for: \.text, options: [.initial, .new])
            .compactMap { $0 }
            .eraseToAnyPublisher()
    }
    
    var textPublisher: AnyPublisher<String, Never> {
        NotificationCenter.default.publisher(
            for: UITextView.textDidChangeNotification,
            object: self
        )
        .compactMap { ($0.object as? UITextView)?.text }
        .eraseToAnyPublisher()
    }
}
