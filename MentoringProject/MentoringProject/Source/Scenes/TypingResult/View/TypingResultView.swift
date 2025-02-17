//
//  TypingResultView.swift
//  MentoringProject
//
//  Created by PKW on 2/17/25.
//

import UIKit

class TypingResultView: BaseView {
    // MARK: 기본 설정

    private let rootScrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.alwaysBounceVertical = true
        scrollview.backgroundColor = .red
        return scrollview
    }()
    
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()

    // MARK: 상단 뷰
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
   
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.iconClose, for: .normal)
        return button
    }()
  
    // MARK: 타이틀 뷰
    private let baseTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
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
    
    private let titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .illustHaruWhole
        return imageView
    }()
    
    // TODO: 스택뷰 적용
    override func configureLayout() {
        addSubview(topView, autoLayout: [.leading(0), .trailing(0), .topSafeArea(0), .height(60)])
        topView.addSubview(closeButton, autoLayout: [.centerY(0), .trailing(20)])
        
        addSubview(rootScrollView, autoLayout: [.leading(0), .trailing(0), .topNext(to: topView, constant: 0), .bottomSafeArea(0)])
       
        rootScrollView.addSubview(baseView, autoLayout: [.leading(0), .trailing(0), .bottom(0), .top(0), .widthEqual(to: rootScrollView, constant: 0)])
        
        baseView.addSubview(baseStackView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
        
        // TODO: 타이틀 뷰 레이아웃
        baseTitleView.autoLayout([.height(172)])
        baseTitleView.addSubview(titleLabel, autoLayout: [.leading(20), .trailing(0), .top(70)])
        baseTitleView.addSubview(subTitleLabel, autoLayout: [.leading(20), .trailing(0), .topNext(to: titleLabel, constant: 16)])
        baseTitleView.addSubview(titleImageView, autoLayout: [.trailing(0), .top(12), .width(110), .height(140)])
        
        baseStackView.addArrangedSubview(baseTitleView)
    }
    
    override func configureView() {
        backgroundColor = .white
    }
}
