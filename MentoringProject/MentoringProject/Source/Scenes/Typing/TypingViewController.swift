//
//  HomeViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/6/25.
//

import Combine
import SafariServices
import UIKit

class TypingViewController<ViewModel: BaseViewModelType>: BaseViewController where ViewModel.Input == TypingViewModel.Input, ViewModel.Output == TypingViewModel.Output {
    private let rootView = TypingView()
    
    private let viewModel: ViewModel
    
    private let inputSubject = PassthroughSubject<ViewModel.Input, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.iconHistory, for: .normal)
        return button
    }()
    
    init(viewModel: ViewModel) {
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
        
        bind()
        configurNavigationBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        rootView.setTextViewFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observeKeyboardEvents()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        stopObservingKeyboardEvents()
    }
    
    func bind() {
        let input = TypingViewModel.Input(
            viewDidLoad: Just(()).eraseToAnyPublisher(),
            textViewTextDidChanged: rootView.typingView.typingTextView.textPublisher,
            textViewContentOffsetDidChange: rootView.typingView.typingTextView.publisher(for: \.contentOffset).eraseToAnyPublisher(),
            keyboardHeight: keyboardHeightPublisher)
        
        let output = viewModel.transform(from: input)
        
        output.updatePlaceholder
            .receive(on: DispatchQueue.main)
            .sink { [weak self] text in
                guard let self = self else { return }
                
                self.rootView.typingView.setTextViewStr(str: text)
            }
            .store(in: &cancellables)
        
        output.updateWPMText
            .receive(on: DispatchQueue.main)
            .sink { [weak self] wpm in
                guard let self = self else { return }
                self.rootView.updateWPMLabel(wpm: wpm)
            }
            .store(in: &cancellables)
        
        output.updateElapsedTime
            .receive(on: DispatchQueue.main)
            .sink { [weak self] seconds in
                guard let self = self else { return }
                self.rootView.updateTimeLabel(seconds: seconds)
            }
            .store(in: &cancellables)
        
        output.showSummaryView
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.showSummaryViewController()
            }
            .store(in: &cancellables)
        
        // TODO: 입력 글자 검사 기능
        
        // 키보드 활성화시 텍스트뷰 바텀 인셋 올리기?
        output.updateTextViewBottomInset
            .receive(on: DispatchQueue.main)
            .sink { [weak self] height in
                guard let self = self else { return }
                self.rootView.typingView.typingTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: height, right: 0)
            }
            .store(in: &cancellables)
        
        output.textViewSyncContentOffsetDidChange
            .receive(on: DispatchQueue.main)
            .sink { [weak self] offset in
                guard let self = self else { return }
                print(offset)
                self.rootView.typingView.typingPlaceholderTextView.contentOffset = offset
            }
            .store(in: &cancellables)
    }
    
    @objc
    func historyButtonTapped() {
        let vc = HistoryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension TypingViewController {
    func configurNavigationBar() {
        navigationTitle = "하루필사"
        
        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        setRightBarButtonItem(item: historyButton)
    }
    
    func showSummaryViewController() {
        let vc = SummaryViewController()
        present(vc, animated: true)
    }
}


extension UIViewController {
    private struct KeyboardHandler {
        static var keyboardHeightSubject = PassthroughSubject<(CGFloat, CGFloat), Never>()
        static var cancellables = Set<AnyCancellable>()
    }
    
    var keyboardHeightPublisher: AnyPublisher<(CGFloat, CGFloat), Never> {
        return KeyboardHandler.keyboardHeightSubject.eraseToAnyPublisher()
    }
    
    // 키보드 감지 시작
    func observeKeyboardEvents() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
            .map { $0.height } // 높이값으로 변환
            .sink { height in // 높이값 방출
                KeyboardHandler.keyboardHeightSubject.send((height, UIScreen.main.bounds.height))
            }
            .store(in: &KeyboardHandler.cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in CGFloat(0) }
            .sink { height in
                KeyboardHandler.keyboardHeightSubject.send((height, UIScreen.main.bounds.height))
            }
            .store(in: &KeyboardHandler.cancellables)
    }
    
    func stopObservingKeyboardEvents() {
        KeyboardHandler.cancellables.removeAll() // ✅ 기존 키보드 구독 해제
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
