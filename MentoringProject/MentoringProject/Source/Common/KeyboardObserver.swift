//
//  KeyboardObserver.swift
//  MentoringProject
//
//  Created by PKW on 2/20/25.
//

import Combine
import Foundation
import UIKit

protocol KeyboardHeightProtocol {
    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> { get }
}

final class KeyboardObserver: KeyboardHeightProtocol {
    private var cancellables = Set<AnyCancellable>()
    private var keyboardHeightSub = CurrentValueSubject<CGFloat, Never>(0)

    var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        return keyboardHeightSub.eraseToAnyPublisher()
    }
    
    init() {
        setupKeyboardNoti()
    }

    private func setupKeyboardNoti() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue }
            .map { $0.cgRectValue.height }
            .sink { [weak self] height in
                guard let self = self else { return }
                self.keyboardHeightSub.send(height)
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
            .sink { [weak self] height in
                guard let self = self else { return }
                self.keyboardHeightSub.send(height)
            }
            .store(in: &cancellables)
    }
}
