//
//  TypingSpeedView.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

class TypingSpeedView: UIView {
    private let speedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.pretendard(type: .pretendardLight, size: 13)
        
        let fullText = "WPM 0"
        let attributedText = NSMutableAttributedString(string: fullText)
        
        if let range = fullText.range(of: "0") {
            let nsRange = NSRange(range, in: fullText)
            attributedText.addAttribute(.font, value: UIFont.pretendard(type: .pretendardBold, size: 13), range: nsRange)
        }
        
        label.attributedText = attributedText
        
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .white
        label.font = UIFont.pretendard(type: .pretendardLight, size: 13)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSpeedView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSpeedView()
    }
}

extension TypingSpeedView {
    func setupSpeedView() {
        backgroundColor = .black
        addSubview(speedLabel, autoLayout: [.leading(20), .centerY(0)])
        addSubview(timeLabel, autoLayout: [.trailing(20), .centerY(0)])
    }

    func updateSpeedLabel(wpm: Int) {
        let fullText = "WPM \(wpm)"
        let attributedText = NSMutableAttributedString(string: fullText)
        
        if let range = fullText.range(of: "\(wpm)") {
            let nsRange = NSRange(range, in: fullText)
            attributedText.addAttribute(.font, value: UIFont.pretendard(type: .pretendardBold, size: 13), range: nsRange)
        }
        
        speedLabel.attributedText = attributedText
    }
}
