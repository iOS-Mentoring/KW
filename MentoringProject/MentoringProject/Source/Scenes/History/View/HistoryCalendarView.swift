//
//  CalendarView.swift
//  MentoringProject
//
//  Created by PKW on 2/23/25.
//

import UIKit

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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {}
}

extension HistoryCalendarView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(CalendarCell.self, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
}
