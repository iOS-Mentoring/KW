//
//  TextViewScrollManager.swift
//  MentoringProject
//
//  Created by PKW on 2/20/25.
//

import Combine
import Foundation
import UIKit

final class TextViewScrollManager: NSObject, UITextViewDelegate {
    private var cancellables = Set<AnyCancellable>()
    private var textViews: [UITextView] = []
    private let keyboardObserver: KeyboardHeightProtocol
    
    init(textViews: [UITextView], keyboardObserver: KeyboardHeightProtocol) {
        guard !textViews.isEmpty else {
            fatalError("TextViewScrollManager는 최소 한 개 이상의 UITextView가 필요합니다.")
        }
        
        self.textViews = textViews
        self.keyboardObserver = keyboardObserver
        super.init()
        observeKeyboardChanges()
    }
    
    // 키보드 활성화 유무에 따라서 텍스트뷰의 바텀 인셋 조절
    private func observeKeyboardChanges() {
        keyboardObserver.keyboardHeightPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] keyboardHeight in
                self?.updateTextViewInsets(with: keyboardHeight)
            }
            .store(in: &cancellables)
    }
    
    private func updateTextViewInsets(with keyboardHeight: CGFloat) {
        let inset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        
        textViews.forEach { textView in
            textView.contentInset = inset
            textView.scrollIndicatorInsets = inset
        }
    }

    func scrollToCursorPosition() {
        let activeTextView = textViews[0]
        
        guard let selectedRange = activeTextView.selectedTextRange else { return }
        
        let caretRect = activeTextView.caretRect(for: selectedRange.end)
        let visibleRect = activeTextView.bounds.inset(by: activeTextView.contentInset)
        
        if caretRect.maxY > visibleRect.maxY {
            activeTextView.scrollRectToVisible(caretRect, animated: true)
            mirrorScrollPosition() // 텍스트뷰 2개일때는 동작 X
        }
    }
    
    func mirrorScrollPosition() {
        guard textViews.count == 2 else { return }
        
        let activeTextView = textViews[0]
        let placeholderTextView = textViews[1]
        
        placeholderTextView.contentOffset = activeTextView.contentOffset
    }
}
