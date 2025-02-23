//
//  BaseViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import Combine
import UIKit

class BaseViewController: UIViewController, UIGestureRecognizerDelegate {
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray200
        configureNavigationBar()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        // 네비게이션 스택의 첫번째인지 체크
        if let nav = navigationController, nav.viewControllers.first != self {
            configureCustomBackButton()
        }
    }
    
    func bindViewModel() {}
    
    private func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .inversePrimaryEmphasis
        
        let titleFont = UIFont.nanumMyeongjo(type: .nanumMyeongjoOTFBold, size: 21)
        
        appearance.titleTextAttributes = [
            .font: titleFont,
            .foregroundColor: UIColor.black,
            .kern: -0.42,
            .paragraphStyle: {
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                style.lineHeightMultiple = 27 / 21
                return style
            }()
        ]
        
        appearance.shadowColor = nil
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
    func configureCustomBackButton() {
        let image = UIImage.iconLeftArrow
        let backButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
