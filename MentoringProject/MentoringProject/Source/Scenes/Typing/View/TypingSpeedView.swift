//
//  TypingSpeedView.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

final class TypingSpeedView: BaseView {
    let speedLabel: UILabel = {
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
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .white
        label.font = UIFont.pretendard(type: .pretendardLight, size: 13)
        return label
    }()
    
    override func configureLayout() {
        addSubview(speedLabel, autoLayout: [.leading(20), .centerY(0)])
        addSubview(timeLabel, autoLayout: [.trailing(20), .centerY(0)])
    }
    
    override func configureView() {
        backgroundColor = .black
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
    
    func updateTimerlabel(seconds: Int) {
        timeLabel.text = "\(seconds.formattedTime())"
    }
}
