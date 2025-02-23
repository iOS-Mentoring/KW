//
//  baseTextView.swift
//  MentoringProject
//
//  Created by PKW on 2/22/25.
//

import Combine
import UIKit

class BaseTextView: UITextView, UITextViewDelegate {
    weak var mirrorTextView: UITextView?
    
    private var cancellables = Set<AnyCancellable>()
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        // 텍스트뷰 델리게이트 설정 (커서 스크롤 처리 등)
        self.delegate = self
        
        // 키보드 노티피케이션을 통해 insets 업데이트 (CombineKeyboard 사용)
        CombineKeyboard.shared.frame
            .receive(on: DispatchQueue.main)
            .sink { [weak self] keyboardFrame in
                guard let self = self else { return }
                self.contentInset.bottom = keyboardFrame.height
                self.scrollIndicatorInsets.bottom = keyboardFrame.height
            }
            .store(in: &cancellables)
    }
    
    private func scrollToCursorPosition() {
        guard let selectedRange = self.selectedTextRange else { return }
        let caretRect = self.caretRect(for: selectedRange.end)
        let visibleRect = self.bounds.inset(by: self.contentInset)

        if caretRect.maxY > visibleRect.maxY {
            self.scrollRectToVisible(caretRect, animated: true)
            mirrorScrollPosition()
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        scrollToCursorPosition()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        mirrorScrollPosition()
    }
    
    func mirrorScrollPosition() {
        mirrorTextView?.contentOffset = self.contentOffset
    }
}
