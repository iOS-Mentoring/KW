//
//  HistoryView.swift
//  MentoringProject
//
//  Created by PKW on 2/23/25.
//

import UIKit
import Combine

class HistoryView: BaseView {
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .crumpledWhitePaper
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let calendarView: HistoryCalendarView
    
    var dateSelectedPublisher: AnyPublisher<Date, Never> {
        return calendarView.dateSelectedPublisher
    }
    
    init(viewModel: HistoryViewModel) {
        calendarView = HistoryCalendarView(viewModel: viewModel)
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureLayout() {
        addSubview(backgroundImageView, autoLayout: [.leading(0), .trailing(0),. top(0), .bottom(0)])
        addSubview(calendarView, autoLayout: [.leading(0), .trailing(0), .topSafeArea(0), .height(94.5)])
    }

    override func configureView() {
       
    }
}
