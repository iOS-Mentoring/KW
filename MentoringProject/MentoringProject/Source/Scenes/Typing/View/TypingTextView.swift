//
//  TypingTextView.swift
//  MentoringProject
//
//  Created by PKW on 2/18/25.
//

import UIKit

class TypingTextView: BaseView {
    private let typingPlaceholderTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .gray200
        textView.font = UIFont.pretendard(type: .pretendardMedium, size: 20)
        textView.isUserInteractionEnabled = false
        
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
        
        return textView
    }()
    
    override func configureLayout() {
        addSubview(typingPlaceholderTextView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
        addSubview(typingTextView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
    }
    
    override func configureView() {
        typingPlaceholderTextView.setLineSpacing(10, textColor: .gray300)
    }
    
    func setTextViewFirstResponder() {
        typingTextView.becomeFirstResponder()
    }
    
    func setTextViewStr(str: String) {
        typingPlaceholderTextView.text = str
        typingPlaceholderTextView.setLineSpacing(10, textColor: .gray300)
    }
}
