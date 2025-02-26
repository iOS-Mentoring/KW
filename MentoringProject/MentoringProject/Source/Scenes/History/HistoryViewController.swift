//
//  TestViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import Combine
import UIKit

final class HistoryViewController: BaseViewController {
    private let rootView: HistoryView
    private let viewModel = HistoryViewModel()
    
    init() {
        self.rootView = HistoryView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "하루 보관함"
        
        bindViewModel()
        rootView.reloadCollectionView() // 컬렉션뷰 센터 정렬
    }
    
    override func bindViewModel() {
        let input = HistoryViewModel.Input(viewDidLoad: Just(()).eraseToAnyPublisher(),
                                           saveButtonTapped: rootView.saveButtonPublisher,
                                           shareButtonTapped: rootView.shareButtonPublisher,
                                           cellTapped: rootView.cellSelection,
                                           scrollPageChanged: rootView.scrollPage)
        
        let output = viewModel.transform(from: input)
        
        output.historyDataUpdated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                
                self.rootView.reloadCollectionView()
                
                if let data = data {
                    self.rootView.showReferenceData()
                    
                    self.rootView.updatePerformanceData(wpm: "\(data.wpm)",
                                                        acc: "\(data.acc)",
                                                        date: data.date.toFormattedDate() ?? "")
                    
                    self.rootView.updateReferenceData(text: data.text,
                                                      title: data.title,
                                                      author: data.author)
                    
                } else {
                    self.rootView.hideReferenceData()
                }
            }
            .store(in: &cancellables)
        
        output.weeksUpdated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.rootView.reloadCollectionView()
            }
            .store(in: &cancellables)
    }
}
