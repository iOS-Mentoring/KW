//
//  TypingView.swift
//  MentoringProject
//
//  Created by PKW on 2/18/25.
//

import UIKit

final class TypingView: BaseView {
    private let speedView = TypingSpeedView()
    private let typingView = TypingTextView()
    private let descriptionView = DescriptionView()

    override func configureLayout() {
        addSubview(speedView, autoLayout: [.leading(0), .trailing(0), .topSafeArea(60), .height(30)])
        addSubview(typingView, autoLayout: [.leading(0), .trailing(0), .topNext(to: speedView, constant: 0), .bottomSafeArea(0)])
        descriptionView.autoLayout([.height(56)])
    }

    override func configureView() {
        typingView.typingTextView.inputAccessoryView = descriptionView
    }

    func setTextViewFirstResponder() {
        typingView.setTextViewFirstResponder()
    }
}
