//
//  TestViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

class HistoryViewController: BaseViewController {
    private let rootView: HistoryView
    private let viewModel = HistoryViewModel()

    init() {
        self.rootView = HistoryView(viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "하루 보관함"
        bindViewModel()
    }
    
    override func bindViewModel() {
        let input = HistoryViewModel.Input(dateSelected: rootView.dateSelectedPublisher)
        
        let output = viewModel.transform(from: input)
        
        output.selectedDate
            .receive(on: DispatchQueue.main)
            .sink { [weak self] selectedDate in
                print("111", selectedDate)
            }
            .store(in: &cancellables)
        
    }
    
}
