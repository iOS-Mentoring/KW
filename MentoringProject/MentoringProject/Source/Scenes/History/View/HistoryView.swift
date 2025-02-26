//
//  HistoryView.swift
//  MentoringProject
//
//  Created by PKW on 2/23/25.
//

import Combine
import UIKit

final class HistoryView: BaseView {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .crumpledWhitePaper
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let haruImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .illustHaruWhole
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let baseScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        return stackView
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let saveImageButton: UIButton = {
        let button = UIButton()
        button.setImage(.iconInverseDownload, for: .normal)
        button.setImage(.iconInverseDownload, for: .highlighted)
        button.layer.borderWidth = 1
        button.layer.borderColor = .gray300
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let shareImageButton: UIButton = {
        let button = UIButton()
        button.setImage(.iconInverseShare, for: .normal)
        button.setImage(.iconInverseShare, for: .highlighted)
        button.layer.borderWidth = 1
        button.layer.borderColor = .gray300
        button.layer.cornerRadius = 18
        return button
    }()
    
    private let viewModel: HistoryViewModel
    private let calendarView: HistoryCalendarView
    private let performanceView = SummaryPerformanceView()
    private let referenceView = SummaryReferenceView()
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        calendarView = HistoryCalendarView(viewModel: viewModel)
        super.init(frame: .zero)
    }
    
    var cellSelection: AnyPublisher<IndexPath?, Never> {
        return calendarView.cellSelection
    }
    
    var scrollPage: AnyPublisher<Int, Never> {
        return calendarView.scrollPage
    }
    
    var saveButtonPublisher: AnyPublisher<Void, Never> {
        return saveImageButton
            .controlPublisher(for: .touchUpInside)
            .map { _ in return () }
            .eraseToAnyPublisher()
    }
    
    var shareButtonPublisher: AnyPublisher<Void, Never> {
        return saveImageButton
            .controlPublisher(for: .touchUpInside)
            .map { _ in return () }
            .eraseToAnyPublisher()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureLayout() {
        // 배경 이미지
        addSubview(backgroundImageView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
        
        // 캘린더 뷰
        addSubview(calendarView, autoLayout: [.leading(0), .trailing(0), .topSafeArea(0), .height(94.5)])
        
        // 스크롤 뷰
        baseStackView.addArrangedSubview(performanceView)
        baseStackView.addArrangedSubview(referenceView)
        
        addSubview(baseScrollView, autoLayout: [
            .leading(0), .trailing(0), .topNext(to: calendarView, constant: 0),
        ])
        baseScrollView.addSubview(baseStackView, autoLayout: [
            .leading(0), .trailing(0), .top(0), .bottom(0), .widthEqual(to: baseScrollView, constant: 0),
        ])
        
        // 바텀 뷰
        addSubview(bottomView, autoLayout: [
            .leading(0), .trailing(0), .topNext(to: baseScrollView, constant: 0), .bottom(0), .height(80),
        ])
        bottomView.addSubview(saveImageButton, autoLayout: [.leading(20), .centerY(0), .width(36), .height(36)])
        bottomView.addSubview(shareImageButton, autoLayout: [.leadingNext(to: saveImageButton, constant: 12), .centerY(0), .width(36), .height(36)])
        
        // 강아지 이미지 뷰
        addSubview(haruImageView, autoLayout: [.bottom(40), .trailing(0), .width(110), .height(140)])
    }

    // 테이블뷰 리르도
    func reloadCollectionView() {
        calendarView.reloadCollectionView()
    }
    
    func updatePerformanceData(wpm: String, acc: String, date: String) {
        performanceView.updatePerformanceData(wpm: wpm, acc: acc, date: date)
    }
    
    func updateReferenceData(text: String, title: String, author: String) {
        referenceView.updateReferenceData(text: text, title: title, author: author)
    }
    
    func hideReferenceData() {
        performanceView.isHidden = true
        referenceView.hideReferenceData()
    }
    
    func showReferenceData() {
        performanceView.isHidden = false
        referenceView.showReferenceData()
    }
}
