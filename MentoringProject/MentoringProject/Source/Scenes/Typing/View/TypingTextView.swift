//
//  TypingTextView.swift
//  MentoringProject
//
//  Created by PKW on 2/18/25.
//

import UIKit

final class TypingTextView: BaseView {
    private let typingPlaceholderTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .gray200
        textView.font = UIFont.pretendard(type: .pretendardMedium, size: 20)
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
        
        return textView
    }()
    
   private let typingTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.pretendard(type: .pretendardMedium, size: 20)
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 16, left: 16, bottom: 10, right: 16)
        
        textView.backgroundColor = .red
        
        textView.alpha = 0.2
        
        return textView
    }()
    
    private var typingInputAccessoryView: TypingInputAccessoryView
    
    init(typingInputAccessoryView: TypingInputAccessoryView) {
        self.typingInputAccessoryView = typingInputAccessoryView
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureLayout() {
        addSubview(typingPlaceholderTextView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
        addSubview(typingTextView, autoLayout: [
            .topEqual(to: typingPlaceholderTextView, constant: 0),
            .leadingEqual(to: typingPlaceholderTextView, constant: 0),
            .trailingEqual(to: typingPlaceholderTextView, constant: 0),
            .bottomEqual(to: typingPlaceholderTextView, constant: 0)
        ])
    }
    
    override func configureView() {
        typingPlaceholderTextView.setLineSpacing(10, textColor: .gray300)
        typingTextView.inputAccessoryView = typingInputAccessoryView
    }
    
    func setTextViewFirstResponder() {
        typingTextView.becomeFirstResponder()
    }
    
    func setTextViewStr(str: String) {
        typingPlaceholderTextView.text = str
//        typingPlaceholderTextView.setLineSpacing(10, textColor: .gray300)
    }
}
