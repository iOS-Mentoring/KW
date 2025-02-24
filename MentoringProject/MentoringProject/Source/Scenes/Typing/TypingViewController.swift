//
//  HomeViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/6/25.
//

import Combine
import SafariServices
import UIKit

class TypingViewController: BaseViewController {
    private let rootView = TypingView()

    private let viewModel: TypingViewModel

    init(viewModel: TypingViewModel) {
        self.viewModel = viewModel
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

        bindViewModel()
        configurNavigationBar()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        rootView.setTextViewFirstResponder()
    }
    
    override func bindViewModel() {
        let input = TypingViewModel.Input(
            onViewDidLoad: Just(()).eraseToAnyPublisher(),
            onTextViewTextChanged: rootView.textViewPublisher)
        
        let output = viewModel.transform(from: input)
        
        // 필사 텍스트 업데이트
        output.placeholderTextUpdated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                self.rootView.setPlaceholderText(text)
            }
            .store(in: &cancellables)
        
        // WPM 업데이트
        output.wpmUpdated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] wpm in
                guard let self = self else { return }
                self.rootView.updateWPMLabel(wpm)
            }
            .store(in: &cancellables)
        
        output.elapsedTimeUpdated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] seconds in
                guard let self = self else { return }
                self.rootView.updateTimeLabel(seconds)
            }
            .store(in: &cancellables)
        
        output.summaryViewPresented
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.showSummaryViewController()
            }
            .store(in: &cancellables)
        
        output.highlightedTextUpdated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                self.rootView.updateHighlightedText(text)
            }
            .store(in: &cancellables)
        
        output.typingStarted
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.rootView.startProgress()
            }
            .store(in: &cancellables)
    }
}

extension TypingViewController {
    func configurNavigationBar() {
        title = "하루필사"
        let historyButton = UIBarButtonItem(
            image: .iconHistory,
            style: .plain,
            target: self,
            action: #selector(historyButtonTapped))

        navigationItem.rightBarButtonItem = historyButton
    }

    @objc func historyButtonTapped() {
        let vc = HistoryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    func showSummaryViewController() {
        let vc = SummaryViewController(viewModel: SummaryViewModel())
        present(vc, animated: true)
    }
}
