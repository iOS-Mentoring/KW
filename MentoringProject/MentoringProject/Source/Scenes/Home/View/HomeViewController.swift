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
    
    private let typingSpeedView = TypingSpeedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupSpeedView()
    }
}

extension HomeViewController {
    // 네비게이션바 설정
    func setupNavigationBar() {
        navigationTitle = "하루필사"
        
        historyButton.addTarget(self, action: #selector(historyButtonTapped), for: .touchUpInside)
        
        setRightBarButtonItem(item: historyButton)
    }
    
    // TODO: 속도 측정 바 설정
    func setupSpeedView() {
        view.addSubview(typingSpeedView, autoLayout: [.leading(0), .trailing(0), .topNext(to: customNavigationBar, constant: 0), .height(30)])
    }
    
    // TODO: 텍스트뷰 2개 생성
    
    // TODO: 텍스트뷰에 붙은 뷰 구현
}

extension HomeViewController {
    @objc func historyButtonTapped() {
        let vc = TestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
