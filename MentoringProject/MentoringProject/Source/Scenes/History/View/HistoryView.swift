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
    
    private let viewModel: HistoryViewModel
    private let calendarView: HistoryCalendarView
    private let performanceView = SummaryPerformanceView()
    private let referenceView = SummaryReferenceView()
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        calendarView = HistoryCalendarView(viewModel: viewModel)
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureLayout() {
        addSubview(backgroundImageView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
        addSubview(bottomView, autoLayout: [.leading(0), .trailing(0), .bottom(0), .height(80)])
        
        addSubview(calendarView, autoLayout: [.leading(0), .trailing(0), .topSafeArea(0), .height(94.5)])
        
        baseStackView.addArrangedSubview(performanceView)
        baseStackView.addArrangedSubview(referenceView)
        
        addSubview(baseScrollView, autoLayout: [.leading(0), .trailing(0), .topNext(to: calendarView, constant: 0), .bottomEqual(to: bottomView, constant: 0)])
        baseScrollView.addSubview(baseStackView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0), .widthEqual(to: baseScrollView, constant: 0)])
    }

    override func configureView() {}
    
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
    
    func updateSelectedCellDot(isData: Bool) {
        calendarView.updateSelectedCellDot(isHidden: isData)
    }
}
