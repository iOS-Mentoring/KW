//
//  TypingSummaryHeaderView.swift
//  MentoringProject
//
//  Created by PKW on 2/17/25.
//

import UIKit

final class SummaryHeaderView: BaseView {
    private let baseHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleLabel: PaddedLabel = {
        let label = PaddedLabel(padding: UIEdgeInsets(top: -10, left: 0, bottom: -10, right: 0))
        label.font = UIFont(name: "TimesNewRomanPS-ItalicMT", size: 50)
        label.attributedText = NSAttributedString(
            string: "Good!",
            attributes: [.kern: -0.05 * 50]
        )
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.pretendard(type: .pretendardMedium, size: 16)
        label.attributedText = NSAttributedString(
            string: "오늘 필사를 완료했어요",
            attributes: [.kern: -0.03 * 16]
        )
        return label
    }()
    
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .illustHaruWhole
        return imageView
    }()
    
    override func configureLayout() {
        addSubview(baseHeaderView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0), .height(172)])
        
        baseHeaderView.addSubview(headerImageView, autoLayout: [.trailing(0), .top(12), .width(110), .height(140)])
        baseHeaderView.addSubview(titleLabel, autoLayout: [.leading(20), .top(70), .trailingEqualGreaterThan(to: headerImageView, constant: 20)])
        baseHeaderView.addSubview(subTitleLabel, autoLayout: [.leading(20), .trailingEqualGreaterThan(to: headerImageView, constant: 20), .topNext(to: titleLabel, constant: 16), .bottom(30)])
    }
}
