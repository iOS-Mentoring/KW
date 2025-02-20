//
//  TypingView.swift
//  MentoringProject
//
//  Created by PKW on 2/18/25.
//

import UIKit
import Combine

final class TypingView: BaseView {
    private let speedView = TypingSpeedView()
    private let typingView = TypingTextView(typingInputAccessoryView: TypingInputAccessoryView())
    
    public var textViewPublisher: AnyPublisher<String, Never> {
        return typingView.textViewPublisher
    }

    override func configureLayout() {
        addSubview(speedView, autoLayout: [.leading(0), .trailing(0), .topSafeArea(0), .height(30)])
        addSubview(typingView, autoLayout: [.topNext(to: speedView, constant: 0), .leading(0), .trailing(0), .bottom(0)])
    }
    
    // MARK: speedView

    func updateTimeLabel(_ seconds: Int) {
        speedView.updateTimerlabel(seconds: seconds)
    }
    
    func updateWPMLabel(_ wpm: Int) {
        speedView.updateWPMLabel(wpm)
    }
    
    // MARK: typingView

    func setTextViewFirstResponder() {
        typingView.setTextViewFirstResponder()
    }
    
    func setPlaceholderText(_ text: String) {
        typingView.setPlaceholderText(text)
    }
}
