//
//  TestViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import Combine
import UIKit

final class HistoryViewController: BaseViewController {
    private let rootView: HistoryView
    private let viewModel = HistoryViewModel()
    
    init() {
        self.rootView = HistoryView(viewModel: viewModel)
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
        title = "하루 보관함"
        
        bindViewModel()
        rootView.reloadCollectionView() // 컬렉션뷰 센터 정렬
    }
    
    override func bindViewModel() {
        let input = HistoryViewModel.Input(viewDidLoad: Just(()).eraseToAnyPublisher(),
                                           saveButtonTapped: rootView.saveButtonPublisher,
                                           shareButtonTapped: rootView.shareButtonPublisher,
                                           cellTapped: rootView.cellSelection,
                                           scrollPageChanged: rootView.scrollPage)
        
        let output = viewModel.transform(from: input)
        
        output.historyDataUpdated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self else { return }
                
                self.rootView.reloadCollectionView()
                
                if let data = data {
                    self.rootView.showReferenceData()
                    
                    self.rootView.updatePerformanceData(wpm: "\(data.wpm)",
                                                        acc: "\(data.acc)",
                                                        date: data.date.toFormattedDate() ?? "")
                    
                    self.rootView.updateReferenceData(text: data.text,
                                                      title: data.title,
                                                      author: data.author)
                    
                } else {
                    self.rootView.hideReferenceData()
                }
            }
            .store(in: &cancellables)
        
        output.weeksUpdated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.rootView.reloadCollectionView()
            }
            .store(in: &cancellables)
        
        output.saveImageTriggered
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self = self else { return }
                self.saveImage(image: image)
            }
            .store(in: &cancellables)
        
        output.shareImageTriggered
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self = self else { return }
                self.shareImage(image: image)
            }
            .store(in: &cancellables)
    }
    
    func saveImage(image: UIImage) {
        SaveImageManager.shared.saveImage(image: image)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { success in
                if success {
                    self.alert(
                        title: "사진 저장 완료",
                        message: "앨범에 사진이 저장 완료 되었습니다.",
                        actions: [.init(title: "확인", style: .default)])
                }
            }
            .store(in: &cancellables)
    }

    func shareImage(image: UIImage) {
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}
