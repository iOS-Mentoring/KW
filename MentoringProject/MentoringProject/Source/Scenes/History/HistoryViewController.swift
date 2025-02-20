//
//  TestViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

class HistoryViewController: BaseViewController {
    private let backButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
}

extension HistoryViewController {
    func setupUI() {
        view.backgroundColor = .white

        // 네비게이션 바 백버튼
        backButton.setImage(.iconLeftArrow, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

//        setLeftBarButtonItem(item: backButton)
    }
}

extension HistoryViewController {
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}
