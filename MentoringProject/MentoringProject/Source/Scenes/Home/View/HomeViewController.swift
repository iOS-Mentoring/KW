//
//  HomeViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/6/25.
//

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
        textView.text = "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다."
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSpeedView()
        setupTypingTextField()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        setupDescriptionView()
        typingTextView.becomeFirstResponder()
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
        
        view.addSubview(typingPlaceholderTextView, autoLayout: [.leading(0), .trailing(0), .topNext(to: typingSpeedView, constant: 0), .bottom(0)])
        view.addSubview(typingTextView, autoLayout: [.leading(0), .trailing(0), .topNext(to: typingSpeedView, constant: 0), .bottom(0)])
        
        typingPlaceholderTextView.setLineSpacing(10, textColor: .gray300)
    }
    
    //
    func setupDescriptionView() {
        typingTextView.inputAssistantItem.leadingBarButtonGroups = []
        typingTextView.inputAssistantItem.trailingBarButtonGroups = []
        
        typingTextView.inputAccessoryView = descriptionView
        typingTextView.reloadInputViews()
    }
}

extension HomeViewController {
    @objc func historyButtonTapped() {
        let vc = TestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        textView.setLineSpacing(10, textColor: .primaryRed)
    }
}
