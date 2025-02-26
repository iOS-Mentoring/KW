//
//  CalendarView.swift
//  MentoringProject
//
//  Created by PKW on 2/23/25.
//

import Combine
import UIKit

enum Weekdays: String, CaseIterable {
    case sun = "Sun"
    case mon = "Mon"
    case tue = "Tue"
    case wed = "Wed"
    case thu = "Thu"
    case fri = "Fri"
    case sat = "Sat"
    
    var color: UIColor { self == .sun ? .red : .black }
}

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
    
    private var cancellables = Set<AnyCancellable>()
    private let cellSelectionSubject = PassthroughSubject<IndexPath?, Never>() // 셀 선택 서브젝트
    private let scrollPageSubject = PassthroughSubject<Int, Never>() // 스크롤 서브젝트
   
    var cellSelection: AnyPublisher<IndexPath?, Never> {
        return cellSelectionSubject.eraseToAnyPublisher()
    }
    
    var scrollPage: AnyPublisher<Int, Never> {
        scrollPageSubject.eraseToAnyPublisher()
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
        for weekday in Weekdays.allCases {
            let label = UILabel()
            label.textColor = weekday.color // weekday.rawValue == "Sun" ? .red : .black
            label.setStyledText(text: weekday.rawValue,
                                font: .pretendard(type: .pretendardRegular, size: 10),
                                lineHeight: 12,
                                letterSpacing: -0.04)
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
    
    // 컬렉션뷰 리로드 후 가운데 정렬
    func reloadCollectionView() {
        collectionView.reloadData()
        let middleOffset = collectionView.bounds.width // 섹션 1로 이동
        collectionView.contentOffset = CGPoint(x: middleOffset, y: 0)
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
        cellSelectionSubject.send(indexPath) // 이벤트 방출만!
    }
    
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
        let currentPage = Int(scrollView.contentOffset.x / pageWidth)
        scrollPageSubject.send(currentPage) // 페이지 변경 이벤트 방출
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
        
        guard let date = viewModel.getDate(for: indexPath) else { return cell } // 셀에 표시할 날짜
        
        let dayStr = viewModel.convertDayToString(date: date) // 2025-02-20 15:00:00 +0000 -> "20"으로 변환
        
        let isSelected = viewModel.isSelectedDate(date: date)
        
        var isDot = false
        
        if isSelected {
            let hasData = viewModel.hasData(date: date)
            isDot = hasData
        } else {
            isDot = false
        }
        
        cell.configurData(day: dayStr, isSelected: isSelected, isDot: isDot)
        
        return cell
    }
}
