//
//  TypingResultViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/17/25.
//

import UIKit

final class SummaryViewController: UIViewController {
   
    private let downloadImageButton: UIButton = {
        let button = UIButton(configuration: .filled())
        var config = button.configuration
        config?.title = "이미지 저장하기"
        config?.image = .iconInverseDownload
        config?.imagePadding = 6
        config?.imagePlacement = .leading
        config?.baseBackgroundColor = .black
        config?.background.cornerRadius = 0
        
        button.configuration = config
        
        return button
    }()
        
    let rootView = SummaryView()
    private let viewModel: SummaryViewModel
    
    init(viewModel: SummaryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(downloadImageButton, autoLayout: [.leading(0), .trailing(0), .bottom(0), .height(70)])
        rootView.closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        downloadImageButton.addTarget(self, action: #selector(downloadImageButtonTapped), for: .touchUpInside)
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
    
    @objc func downloadImageButtonTapped() {
        guard let capturedImage = view.captureImage() else {
            print("캡처 실패")
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [capturedImage], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
}
