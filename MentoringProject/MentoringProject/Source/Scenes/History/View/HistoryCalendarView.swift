//
//  CalendarView.swift
//  MentoringProject
//
//  Created by PKW on 2/23/25.
//

import UIKit
import Combine

class HistoryCalendarView: BaseView {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 12, right: 20)
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let viewModel: HistoryViewModel
    private let dateSelected = PassthroughSubject<Date, Never>()
    
    var dateSelectedPublisher: AnyPublisher<Date, Never> {
        return dateSelected.eraseToAnyPublisher()
    }

    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureLayout() {
        addSubview(collectionView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
    }
    
    override func configureView() {
        backgroundColor = .white

        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.registerCell(ofType: CalendarCell.self, withReuseIdentifier: CalendarCell.reuseIdentifier)
    }
}

extension HistoryCalendarView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width - 20 - 20
        let cellWidth = availableWidth / 7
        let cellHeight = collectionView.bounds.height - 32
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}

extension HistoryCalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedDate = viewModel.getWeekDates()[indexPath.item]
        dateSelected.send(selectedDate)
        collectionView.reloadData()
    }
}

extension HistoryCalendarView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getWeekDates().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CalendarCell.self, for: indexPath)
        
        let date = viewModel.getWeekDates()[indexPath.item]
        
        let shortDay = viewModel.getShortWeekday(for: date)
        let day = viewModel.getDay(from: date)
        let isSelected = viewModel.isSelectedDate(date)
        
        cell.configurData(dayOfWeek: shortDay, day: day, isSelected: isSelected)
        
        return cell
    }
}
