//
//  TypingResultView.swift
//  MentoringProject
//
//  Created by PKW on 2/17/25.
//

import UIKit

final class SummaryView: BaseView {
    private let baseView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .crumpledWhitePaper
        imageView.contentMode = .scaleAspectFill
        imageView.alpha = 1
        return imageView
    }()

    let scrollView: UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.alwaysBounceVertical = true
        scrollview.backgroundColor = .clear
        return scrollview
    }()

    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.backgroundColor = .clear
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

    let headerView = SummaryHeaderView()
    let performanceView = SummaryPerformanceView()
    let referenceView = SummaryReferenceView()

    override func configureLayout() {
        addSubview(backgroundImageView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
        addSubview(topView, autoLayout: [.leading(0), .trailing(0), .topSafeArea(0), .height(60)])
        topView.addSubview(closeButton, autoLayout: [.centerY(0), .trailing(20)])

        addSubview(scrollView, autoLayout: [.leading(0), .trailing(0), .topNext(to: topView, constant: 0), .bottomSafeArea(0)])
        scrollView.addSubview(baseView, autoLayout: [.leading(0), .trailing(0), .bottom(0), .top(0), .widthEqual(to: scrollView, constant: 0)])
        baseView.addSubview(baseStackView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])

        baseStackView.addArrangedSubview(headerView)
        baseStackView.addArrangedSubview(performanceView)
        baseStackView.addArrangedSubview(referenceView)
    }

    override func configureView() {
        backgroundColor = .white
    }
}
