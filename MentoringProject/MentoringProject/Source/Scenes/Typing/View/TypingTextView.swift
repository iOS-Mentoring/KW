//
//  TypingTextView.swift
//  MentoringProject
//
//  Created by PKW on 2/18/25.
//

import UIKit

final class TypingTextView: BaseView {
    let typingPlaceholderTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .gray200
        textView.font = UIFont.pretendard(type: .pretendardMedium, size: 20)
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 21, left: 20, bottom: 20, right: 20)
        
        return textView
    }()
    
    let typingTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.pretendard(type: .pretendardMedium, size: 20)
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 21, left: 20, bottom: 20, right: 20)
        
        textView.backgroundColor = .red
        
        textView.alpha = 0.2
        
        return textView
    }()
    
    override func configureLayout() {
        addSubview(typingPlaceholderTextView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottomSafeArea(0)])
        addSubview(typingTextView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottomSafeArea(0)])
    }
    
    override func configureView() {
        typingTextView.inputAccessoryView = typingInputAccessoryView
    }
    
    func setTextViewFirstResponder() {
        typingTextView.becomeFirstResponder()
    }
    
    func setTextViewStr(str: String) {
        typingPlaceholderTextView.text = str
    }
}
