//
//  SummaryReferenceView.swift
//  MentoringProject
//
//  Created by PKW on 2/17/25.
//

import UIKit

final class SummaryReferenceView: BaseView {
    private let baseReferenceView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let doubleQuotesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = .init(x: 0, y: 0, width: 24, height: 24)
        imageView.image = .iconDoubleQuotes
        return imageView
    }()
    
    private let typingStrLabel: UILabel = {
        let label = UILabel()
        label.textColor = .primaryEmphasis
        label.numberOfLines = 0
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
//        label.font = .pretendard(type: .pretendardSemiBold, size: 16)
        label.textColor = .primaryEmphasis
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
//        label.font = .pretendard(type: .pretendardRegular, size: 12)
        label.textColor = .primaryEmphasis
        return label
    }()
    
    override func configureLayout() {
        addSubview(baseReferenceView, autoLayout: [.leading(0),. trailing(0), .top(0), .bottom(0)])
        baseReferenceView.addSubview(doubleQuotesImageView, autoLayout: [.leading(20), .top(40), .trailingLessThan(20)])
        baseReferenceView.addSubview(typingStrLabel, autoLayout: [.leading(20), .trailing(20),. topNext(to: doubleQuotesImageView, constant: 20)])
        baseReferenceView.addSubview(titleLabel, autoLayout: [.leading(20), .trailing(20),. topNext(to: typingStrLabel, constant: 30)])
        baseReferenceView.addSubview(authorLabel, autoLayout: [.leading(20), .trailing(20),. topNext(to: titleLabel, constant: 6), .bottom(110)])
    }
    
    func updateReferenceData(text: String, title: String, author: String) {
        typingStrLabel.setStyledText(text: text,
                                     font: .pretendard(type: .pretendardRegular, size: 18),
                                     lineHeight: 28,
                                     letterSpacing: -0.04,
                                     textAlignment: .left)
        
        titleLabel.setStyledText(text: title,
                                 font: .pretendard(type: .pretendardSemiBold, size: 16),
                                 lineHeight: 19,
                                 letterSpacing: -0.04,
                                 textAlignment: .left)
        
        authorLabel.setStyledText(text: author,
                                  font: .pretendard(type: .pretendardRegular, size: 12),
                                  lineHeight: 16,
                                  letterSpacing: -0.04,
                                  textAlignment: .left)
    }
    
    func hideReferenceData() {
        typingStrLabel.setStyledText(text: "하루가 기다리고 있어요!\n얼른 필사하며 하루를 쌓아보세요!",
                                     font: .pretendard(type: .pretendardRegular, size: 18),
                                     lineHeight: 28,
                                     letterSpacing: -0.04,
                                     textAlignment: .left)
        titleLabel.isHidden = true
        authorLabel.isHidden = true
    }
    
    func showReferenceData() {
        titleLabel.isHidden = false
        authorLabel.isHidden = false
    }
}
