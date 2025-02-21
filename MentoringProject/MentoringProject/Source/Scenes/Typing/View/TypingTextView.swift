//
//  TypingTextView.swift
//  MentoringProject
//
//  Created by PKW on 2/18/25.
//

import Combine
import UIKit

final class TypingTextView: BaseView {
    private let typingPlaceholderTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.pretendard(type: .pretendardMedium, size: 20)
        textView.backgroundColor = .clear
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 21, left: 20, bottom: 21, right: 20)
        textView.isEditable = false
        
        return textView
    }()
    
    private let typingTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.pretendard(type: .pretendardMedium, size: 20)
        textView.backgroundColor = .clear
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 21, left: 20, bottom: 21, right: 20)
        
        return textView
    }()

    private var typingInputAccessoryView: TypingInputAccessoryView
    
    // 퍼블리셔 외부에서 사용가능하도록
    var textViewPublisher: AnyPublisher<String, Never> {
        return typingTextView.textPublisher
    }
    
    var activeTextView: UITextView {
        return typingTextView
    }
    
    var scrollTextViews: [UITextView] {
        return [typingTextView, typingPlaceholderTextView]
    }
    
    init(typingInputAccessoryView: TypingInputAccessoryView) {
        self.typingInputAccessoryView = typingInputAccessoryView
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
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
        backgroundColor = .gray200
        typingTextView.inputAccessoryView = typingInputAccessoryView
    }
    
    func setTextViewFirstResponder() {
        typingTextView.becomeFirstResponder()
    }
    
    func setPlaceholderText(_ text: String) {
        typingPlaceholderTextView.text = text
        typingPlaceholderTextView.setLineSpacing(10)
    }
    
    func updateHighlightedText(_ text: NSAttributedString) {
        typingTextView.attributedText = text
    }
}
