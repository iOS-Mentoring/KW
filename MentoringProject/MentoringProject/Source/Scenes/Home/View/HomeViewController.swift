//
//  HomeViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/6/25.
//

import Combine
import UIKit

class HomeViewController: BaseViewController {
    // MARK: 네비게이션바 버튼 설정
    
    private let historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.iconHistory, for: .normal)
        return button
    }()
    
    private let typingPlaceholderTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .gray200
        textView.font = UIFont.pretendard(type: .pretendardMedium, size: 20)
        
        textView.isUserInteractionEnabled = false
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 21, left: 20, bottom: 20, right: 20)
        
        return textView
    }()
    
    private let typingTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = UIFont.pretendard(type: .pretendardMedium, size: 20)
        
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = UIEdgeInsets(top: 21, left: 20, bottom: 20, right: 20)
        
        return textView
    }()
    
    private let typingSpeedView = TypingSpeedView()
    private let descriptionView = DescriptionView()
    
    private let viewModel = HomeViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSpeedView()
        setupTypingTextField()
        
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        setupDescriptionView()
        typingTextView.becomeFirstResponder()
    }
    
    private func bindViewModel() {
        viewModel.$typingSpeed
            .receive(on: DispatchQueue.main)
            .sink { [weak self] speedModel in
                guard let self = self else { return }
                self.typingSpeedView.updateSpeedLabel(wpm: speedModel.wpm)
            }
            .store(in: &cancellables)
        
        viewModel.$elapsedTime
            .receive(on: DispatchQueue.main)
            .sink { [weak self] time in
                guard let self = self else { return }
                self.typingSpeedView.timeLabel.text = "\(time.formattedTime())"
            }
            .store(in: &cancellables)
        
        viewModel.$attributedStr
            .receive(on: DispatchQueue.main)
            .sink { [weak self] attStr in
                guard let self = self else { return }
                self.typingTextView.attributedText = attStr
            }
            .store(in: &cancellables)
    }
}

extension HomeViewController {
    // 네비게이션 바 세팅
    func setupNavigationBar() {
        navigationTitle = "하루필사"
        
        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        
        setRightBarButtonItem(item: historyButton)
    }
    
    // 속도 측정 뷰 세팅
    func setupSpeedView() {
        view.addSubview(typingSpeedView, autoLayout: [.leading(0), .trailing(0), .topNext(to: customNavigationBar, constant: 0), .height(30)])
    }
    
    // 텍스트 뷰 세팅
    func setupTypingTextField() {
        typingTextView.delegate = self
        
        typingPlaceholderTextView.text = viewModel.typingStr
        
        view.addSubview(typingPlaceholderTextView, autoLayout: [.leading(0), .trailing(0), .topNext(to: typingSpeedView, constant: 0), .bottom(0)])
        view.addSubview(typingTextView, autoLayout: [.leading(0), .trailing(0), .topNext(to: typingSpeedView, constant: 0), .bottom(0)])
        
        typingPlaceholderTextView.setLineSpacing(10, textColor: .gray300)
    }
    
    func setupDescriptionView() {
        typingTextView.inputAssistantItem.leadingBarButtonGroups = []
        typingTextView.inputAssistantItem.trailingBarButtonGroups = []
        
        typingTextView.inputAccessoryView = descriptionView
        typingTextView.reloadInputViews()
    }
}

extension HomeViewController {
    @objc func historyButtonTapped() {
        let vc = HistoryViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.inputStr = textView.text ?? ""
    }
}
