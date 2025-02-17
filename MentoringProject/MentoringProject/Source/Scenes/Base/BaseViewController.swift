//
//  BaseViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

class BaseViewController: UIViewController {
    let customNavigationBar = NavigationBarView()
    
    var navigationTitle: String? {
        get {
            customNavigationBar.titleLabel.text
        } set {
            customNavigationBar.titleLabel.text = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomNavigationBar()
    }
        
    // 네비게이션바 설정
    private func setupCustomNavigationBar() {
        view.addSubview(customNavigationBar, autoLayout: [.leading(0), .trailing(0), .topSafeArea(0), .height(60)])
    }
    
    // 왼쪽 아이템 추가하기
    func setLeftBarButtonItem(item: UIButton) {
        customNavigationBar.leftStackView.addArrangedSubview(item)
    }
    
    // 오른쪽 아이템 추가하기
    func setRightBarButtonItem(item: UIButton) {
        customNavigationBar.rightStackView.addArrangedSubview(item)
    }
}
