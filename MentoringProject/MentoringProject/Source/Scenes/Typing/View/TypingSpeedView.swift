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
        
    private let progressView: UIView = {
        let view = UIView()
        view.backgroundColor = .primaryRed
        return view
    }()
    
    override func configureLayout() {
        addSubview(progressView, autoLayout: [.leading(0), .top(0), .bottom(0), .width(UIScreen.main.bounds.width)])
        addSubview(speedLabel, autoLayout: [.leading(20), .centerY(0)])
        addSubview(timeLabel, autoLayout: [.trailing(20), .centerY(0)])
    }
    
    override func configureView() {
        backgroundColor = .black
        progressView.isHidden = true
    }
    
    func updateWPMLabel(_ wpm: Int) {
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
    
    func startProgress() {
        progressView.isHidden = false
        
        UIView.animate(withDuration: 60, delay: 0, options: .curveLinear) {
            self.progressView.updateConstraint(of: .width, constant: 0)
            self.layoutIfNeeded()
        }
    }
    
    func resetProgress() {
        progressView.isHidden = true
        progressView.layer.removeAllAnimations()
        progressView.updateConstraint(of: .width, constant: UIScreen.main.bounds.width)
    }
}
