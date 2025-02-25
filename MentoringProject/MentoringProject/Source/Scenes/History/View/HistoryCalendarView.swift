//
//  CalendarView.swift
//  MentoringProject
//
//  Created by PKW on 2/23/25.
//

import Combine
import UIKit

final class HistoryCalendarView: BaseView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
    
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let viewModel: HistoryViewModel
    private var isInitialScrollDone = false
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 가운데 인덱스 위치로 이동하도록
        if !isInitialScrollDone {
            DispatchQueue.main.async {
                self.collectionView.contentOffset.x = self.collectionView.bounds.width
                self.isInitialScrollDone = true
            }
        }
    }
    
    override func configureLayout() {
        let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        
        for weekday in weekdays {
            let label = UILabel()
            label.textColor = weekday == "Sun" ? .red : .black
            label.setStyledText(text: weekday,
                                 font: .pretendard(type: .pretendardRegular, size: 10),
                                 letterSpacing: -0.4,
                                 textAlignment: .center)
            stackView.addArrangedSubview(label)
           
        }
        
        addSubview(stackView, autoLayout: [.leading(20), .trailing(20), .top(20)])
        addSubview(collectionView, autoLayout: [.leading(0), .trailing(0), .topNext(to: stackView, constant: 0), .bottom(0)])
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
        
        let availableWidth = collectionView.bounds.width - 40
        let cellWidth = availableWidth / 7
        let cellHeight = collectionView.bounds.height - 23
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 11, left: 20, bottom: 12, right: 20)
    }
}

extension HistoryCalendarView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let date = viewModel.getDate(for: indexPath) else { return } // 선택한 날짜
        
        var indexPathsToReload: [IndexPath] = [] // 리로드 할 셀 인덱스 패스
        
        if let previousIndexPath = viewModel.getSelectedIndexPath() { // 이전에 선택했던 셀 인덱스패스
            indexPathsToReload.append(previousIndexPath)
        }
        
        indexPathsToReload.append(indexPath) // 새로 선택한 인덱스 패스
        
        viewModel.setSelectedDate(date)
        viewModel.setSelectedIndexPath(indexPath: indexPath)
    
        collectionView.reloadItems(at: indexPathsToReload)
    }
    
    // 스크롤이 끝났을때 동작
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageWidth = scrollView.bounds.width // 페이징할 섹션의 넓이
        let targetPage = targetContentOffset.pointee.x / pageWidth // 스크롤할 페이지 0, 1, 2
        
        // 스크롤 범위를 지정해서 일정 범위내로 스크롤 했다면 중앙으로 이동하기
        if targetPage > 0.4 && targetPage < 1.6 {
            targetContentOffset.pointee.x = pageWidth
        }
    }
    
    // 스크롤이 완전히 멈췄을때 호출
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        let currentPage = Int(scrollView.contentOffset.x / pageWidth) // 현재 페이지 인덱스
        
        if currentPage == 0 { // 충분히 왼쪽으로 스크롤한 경우 이전 주로 이동
            viewModel.moveToPreviousWeek() // -1주 데이터 가져오기
            collectionView.reloadData()
            collectionView.contentOffset.x = pageWidth // 중앙으로 리셋
        } else if currentPage == 2 { // 충분히 오른쪽으로 스크롤한 경우 다음 주로 이동
            viewModel.moveToNextWeek() // +1주 데이터 가져오기
            collectionView.reloadData()
            collectionView.contentOffset.x = pageWidth // 중앙으로 리셋
        }
    }
}

extension HistoryCalendarView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.getWeeks().count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CalendarCell.self, for: indexPath)
        
        guard let date = viewModel.getDate(for: indexPath) else { return cell }
        
        let shortDay = viewModel.getShortWeekday(for: date)
        let day = viewModel.getDay(from: date)
       
        let isSelected = viewModel.isSelectedDate(date: date)
        
        cell.configurData(dayOfWeek: shortDay, day: day, isSelected: isSelected)
        
        return cell
    }
}
