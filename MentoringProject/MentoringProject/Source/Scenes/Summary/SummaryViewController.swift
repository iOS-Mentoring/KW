//
//  TypingResultViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/17/25.
//

import UIKit

final class SummaryViewController: UIViewController {
    let rootView = SummaryView()
    
    private let downloadView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(downloadView, autoLayout: [.leading(0), .trailing(0), .bottom(0), .height(70)])
        rootView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
    }
    
    //    override func viewDidLayoutSubviews() {
    //        super.viewDidLayoutSubviews()
    //        updateScrollEnabledState()
    //    }
    
    private func updateScrollEnabledState() {
        //        let contentHeight = rootView.rootScrollView.contentSize.height
        //        let scrollViewHeight = rootView.rootScrollView.bounds.height
        //        rootView.rootScrollView.isScrollEnabled = contentHeight > scrollViewHeight
    }
    
    @objc func closeButtonTapped() {
        self.dismiss(animated: true)
    }
}
