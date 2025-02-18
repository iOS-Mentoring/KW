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
        textView.text = "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다."
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
}
