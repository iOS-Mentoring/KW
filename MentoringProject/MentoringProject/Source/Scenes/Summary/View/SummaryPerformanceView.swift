//
//  PerformanceView.swift
//  MentoringProject
//
//  Created by PKW on 2/17/25.
//

import UIKit

final class SummaryPerformanceView: BaseView {
    
    private let basePerformanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    private let wpmLabel = UILabel()
    private let accLabel = UILabel()
    private let dateLabel = UILabel()
    
    private lazy var wpmView: UIView = createPerformanceView(title: "WPM", valueLabel: wpmLabel)
    private lazy var accView: UIView = createPerformanceView(title: "ACC", valueLabel: accLabel)
    private lazy var dateView: UIView = createPerformanceView(title: "Date", valueLabel: dateLabel)
    
    override func configureLayout() {

        [createBorderView(), createBorderView()].enumerated().forEach { index, borderView in
            addSubview(borderView, autoLayout: [
                .leading(20), .trailing(20),
                index == 0 ? .top(0) : .bottom(0), .height(1)
            ])
        }
        
        addSubview(basePerformanceStackView, autoLayout: [.leading(20), .trailing(20), .top(0), .bottom(0), .height(88)])
        
        let separatorView1 = createSeparatorView()
        let separatorView2 = createSeparatorView()
        
        [wpmView, separatorView1, accView, separatorView2, dateView].forEach {
            basePerformanceStackView.addArrangedSubview($0)
        }
        
        wpmView.autoLayout([.widthEqual(to: accView, constant: 0)])
        accView.autoLayout([.widthEqual(to: dateView, constant: 0)])
    }
    
    private func createPerformanceView(title: String, valueLabel: UILabel) -> UIView {
        let view = UIView()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        
        let titleLabel = UILabel()
        titleLabel.textColor = .black
        titleLabel.attributedText = NSAttributedString(
            string: title,
            attributes: [
                .font: UIFont.pretendard(type: .pretendardMedium, size: 11),
                .kern: -0.025 * 11]
        )
    
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(valueLabel)
        
        view.addSubview(stackView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
        
        return view
    }
    
    private func createSeparatorView() -> UIView {
        let view = UIView()
        view.backgroundColor = .primaryEmphasis
        view.autoLayout([.width(0.5), .height(35)])
        return view
    }
    
    private func createBorderView() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }
    
    func updatePerformanceData(wpm: String, acc: String, date: String) {
        setValueText(label: wpmLabel, text: wpm)
        setACCText(label: accLabel, text: acc)
        setValueText(label: dateLabel, text: date)
    }
    
    private func setValueText(label: UILabel, text: String) {
        label.attributedText = NSAttributedString(
            string: text,
            attributes: [
                .font: UIFont.pretendard(type: .pretendardBold, size: 20),
                .kern: -0.025 * label.font.pointSize
            ]
        )
    }
    
    private func setACCText(label: UILabel, text: String) {
        let formattedText = "\(text)%"
        let characters = Array(formattedText)
        
        let attributedString = NSMutableAttributedString()
        
        for (_, char) in characters.enumerated() {
            let isPercent = char == "%"
            let fontSize: CGFloat = isPercent ? 14 : 20
            let kernValue: CGFloat = -0.025 * fontSize
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.pretendard(type: .pretendardBold, size: fontSize),
                .kern: kernValue
            ]
            
            let attributedChar = NSAttributedString(string: String(char), attributes: attributes)
            attributedString.append(attributedChar)
        }
        
        label.attributedText = attributedString
    }
}
