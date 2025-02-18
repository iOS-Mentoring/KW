//
//  BaseViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

class BaseViewController: UIViewController {
    let naviavigationBar = NavigationBarView()
    
    var navigationTitle: String? {
        get {
            naviavigationBar.titleLabel.text
        } set {
            naviavigationBar.titleLabel.text = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomNavigationBar()
    }
        
    // 네비게이션바 설정
    private func setupCustomNavigationBar() {
        view.addSubview(naviavigationBar, autoLayout: [.leading(0), .trailing(0), .topSafeArea(0), .height(60)])
    }
    
    // 왼쪽 아이템 추가하기
    func setLeftBarButtonItem(item: UIButton) {
        naviavigationBar.leftStackView.addArrangedSubview(item)
    }
    
    // 오른쪽 아이템 추가하기
    func setRightBarButtonItem(item: UIButton) {
        naviavigationBar.rightStackView.addArrangedSubview(item)
    }
}
