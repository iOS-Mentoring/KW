//
//  TestViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import Combine
import UIKit

class HistoryViewController: BaseViewController {
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
    }

    override func bindViewModel() {
        let input = HistoryViewModel.Input(
            onViewDidLoad: Just(Date()).eraseToAnyPublisher())

        let output = viewModel.transform(from: input)

        output.historyDataUpdated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self, let data = data else {
                    self?.rootView.hideReferenceData()
                    self?.rootView.updateSelectedCellDot(isData: true)
                    return
                }

                self.rootView.showReferenceData()
                self.rootView.updateSelectedCellDot(isData: false)

                self.rootView.updatePerformanceData(
                    wpm: "\(data.wpm)",
                    acc: "\(data.acc)",
                    date: "\(data.date.toFormattedDate() ?? "")")

                self.rootView.updateReferenceData(
                    text: data.text,
                    title: data.title,
                    author: data.author)
            }
            .store(in: &cancellables)
    }
}
