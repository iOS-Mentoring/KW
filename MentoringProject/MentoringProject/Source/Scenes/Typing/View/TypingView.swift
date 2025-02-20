//
//  TypingView.swift
//  MentoringProject
//
//  Created by PKW on 2/18/25.
//

import UIKit

final class TypingView: BaseView {
    private let speedView = TypingSpeedView()
    private let typingView = TypingTextView(typingInputAccessoryView: TypingInputAccessoryView())

    override func configureLayout() {
        addSubview(speedView, autoLayout: [.leading(0), .trailing(0), .topSafeArea(0), .height(30)])
        addSubview(typingView, autoLayout: [.topNext(to: speedView, constant: 0), .leading(0), .trailing(0), .bottom(0)])
    }
    
    // MARK: speedView

    func updateTimeLabel(seconds: Int) {
        speedView.updateTimerlabel(seconds: seconds)
    }
    
    func updateWPMLabel(wpm: Int) {
        speedView.updateSpeedLabel(wpm: wpm)
    }
    
    // MARK: typingView

    func setTextViewFirstResponder() {
        typingView.setTextViewFirstResponder()
    }
    
    func setTextViewStr(str: String) {
        typingView.setTextViewStr(str: str)
    }
}
