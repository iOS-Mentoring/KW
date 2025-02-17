//
//  PerformanceView.swift
//  MentoringProject
//
//  Created by PKW on 2/17/25.
//

import UIKit

final class SummaryPerformanceView: BaseView {
    
    private let basePerformanceView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let basePerformanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var wpmView: UIView = createPerformanceView(title: "WPM")
    private lazy var accView: UIView = createPerformanceView(title: "ACC")
    private lazy var dateView: UIView = createPerformanceView(title: "Date")

    override func configureLayout() {
        let separatorView1 = createSeparatorView()
        let separatorView2 = createSeparatorView()
        
        let borderView1 = createBorderView()
        let borderView2 = createBorderView()
        
        addSubview(basePerformanceView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0), .height(88)])
        basePerformanceView.addSubview(basePerformanceStackView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
        
        basePerformanceView.addSubview(borderView1, autoLayout: [.leading(20), .trailing(20), .top(0), .height(1)])
        basePerformanceStackView.addArrangedSubview(wpmView)
        basePerformanceStackView.addArrangedSubview(separatorView1)
        basePerformanceStackView.addArrangedSubview(accView)
        basePerformanceStackView.addArrangedSubview(separatorView2)
        basePerformanceStackView.addArrangedSubview(dateView)
        basePerformanceView.addSubview(borderView2, autoLayout: [.leading(20), .trailing(20), .bottom(0), .height(1)])
        
        wpmView.autoLayout([.widthEqual(to: accView, constant: 0)])
        accView.autoLayout([.widthEqual(to: dateView, constant: 0)])
    }
    
    private func createPerformanceView(title: String) -> UIView {
        let view = UIView()
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .center
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.pretendard(type: .pretendardMedium, size: 11)
        titleLabel.textColor = .black
        titleLabel.attributedText = NSAttributedString(
            string: title,
            attributes: [.kern: -0.025 * 11]
        )
        
        let valueLabel = UILabel()
        valueLabel.font = UIFont.pretendard(type: .pretendardBold, size: 20)
        valueLabel.attributedText = NSAttributedString(
            string: " ",
            attributes: [.kern: -0.025 * 20]
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
}
