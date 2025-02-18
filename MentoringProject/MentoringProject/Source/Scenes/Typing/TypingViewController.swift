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
    
    private let viewModel = TypingViewModel()
    private let input: PassthroughSubject<TypingViewModel.Input, Never> = .init()
    private var cancellables = Set<AnyCancellable>()

    private let historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.iconHistory, for: .normal)
        return button
    }()

    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        bind()
        
        configurNavigationBar()
        
        self.input.send(.viewDidLoad)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        rootView.setTextViewFirstResponder()
    }
    
    func bind() {
        let output = viewModel.transform(input: input.eraseToAnyPublisher())
        
        output
            .sink { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .fetchTypingString(let str):
                rootView.setTextViewStr(str: str)
            }
        }.store(in: &cancellables)
    }
}












extension TypingViewController {
    func configurNavigationBar() {
        navigationTitle = "하루필사"

        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        setRightBarButtonItem(item: historyButton)
    }

    @objc func historyButtonTapped() {
//        let vc = SummaryViewController()
//        present(vc, animated: true)
    }
}
























//
//
//
//    private let typingSpeedView = TypingSpeedView()
//    private let descriptionView = DescriptionView()
//
//    private let viewModel = TypingViewModel()
//    private var cancellables = Set<AnyCancellable>()

//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)

//        setupDescriptionView()
//        typingTextView.becomeFirstResponder()
//    }

//    private func bindViewModel() {
//        viewModel.$typingSpeed
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] speedModel in
//                guard let self = self else { return }
//                self.typingSpeedView.updateSpeedLabel(wpm: speedModel.wpm)
//            }
//            .store(in: &cancellables)
//
//        viewModel.$elapsedTime
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] time in
//                guard let self = self else { return }
//                self.typingSpeedView.timeLabel.text = "\(time.formattedTime())"
//            }
//            .store(in: &cancellables)
//
//        viewModel.$attributedStr
//            .receive(on: DispatchQueue.main)
//            .sink { [weak self] attStr in
//                guard let self = self else { return }
//                self.typingTextView.attributedText = attStr
//            }
//            .store(in: &cancellables)
//    }
// }
//
// extension TypingViewController {
//    // 네비게이션 바 세팅
//    func setupNavigationBar() {
//        navigationTitle = "하루필사"
//
//        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
//
//        setRightBarButtonItem(item: historyButton)
//    }
//
//    // 속도 측정 뷰 세팅
//    func setupSpeedView() {
//        view.addSubview(typingSpeedView, autoLayout: [.leading(0), .trailing(0), .topNext(to: customNavigationBar, constant: 0), .height(30)])
//    }
//
//    // 텍스트 뷰 세팅
//    func setupTypingTextField() {
//        typingTextView.delegate = self
//
//        typingPlaceholderTextView.text = viewModel.typingStr
//
//        view.addSubview(typingPlaceholderTextView, autoLayout: [.leading(0), .trailing(0), .topNext(to: typingSpeedView, constant: 0), .bottom(0)])
//        view.addSubview(typingTextView, autoLayout: [.leading(0), .trailing(0), .topNext(to: typingSpeedView, constant: 0), .bottom(0)])
//
//        typingPlaceholderTextView.setLineSpacing(10, textColor: .gray300)
//    }
//
//    func setupDescriptionView() {
//        typingTextView.inputAssistantItem.leadingBarButtonGroups = []
//        typingTextView.inputAssistantItem.trailingBarButtonGroups = []
//
//        typingTextView.inputAccessoryView = descriptionView
//        typingTextView.reloadInputViews()
//
//        descriptionView.linkButton.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
//    }
// }
//
// extension TypingViewController {

//
//    @objc func linkButtonTapped() {
//        guard let url = URL(string: "https://www.google.com") else { return }
//        let safariVC = SFSafariViewController(url: url)
//        safariVC.modalPresentationStyle = .fullScreen
//        present(safariVC, animated: true)
//    }
// }
//
// extension TypingViewController: UITextViewDelegate {
//    func textViewDidChange(_ textView: UITextView) {
//        viewModel.inputStr = textView.text ?? ""
//    }
// }
