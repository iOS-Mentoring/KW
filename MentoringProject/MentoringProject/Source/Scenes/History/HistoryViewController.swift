//
//  TestViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import Combine
import UIKit

class HistoryViewController: BaseViewController {
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
    }

    override func bindViewModel() {
        let input = HistoryViewModel.Input(viewDidLoad: Just(Date()).eraseToAnyPublisher(),
                                           saveButtonTap: rootView.saveButtonTapPublisher,
                                           shareButtonTap: rootView.shareButtonTapPublisher)

        let output = viewModel.transform(from: input)

        output.historyDataUpdated
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                guard let self = self, let data = data else {
                    self?.rootView.hideReferenceData()
                    self?.rootView.updateSelectedCellDot(isData: true)
                    return
                }

                self.rootView.showReferenceData()
                self.rootView.updateSelectedCellDot(isData: false)

                self.rootView.updatePerformanceData(
                    wpm: "\(data.wpm)",
                    acc: "\(data.acc)",
                    date: "\(data.date.toFormattedDate() ?? "")")

                self.rootView.updateReferenceData(
                    text: data.text,
                    title: data.title,
                    author: data.author)
            }
            .store(in: &cancellables)

        output.saveButtonAction
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                saveImage()
            }
            .store(in: &cancellables)

        output.shareButtonAction
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                shareImage()
            }
            .store(in: &cancellables)
    }

    func saveImage() {
        guard let capturedImage = UIApplication.shared.captureEntireWindow() else { return }

        SaveImageManager.shared.saveImage(image: capturedImage)
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

    func shareImage() {
        guard let capturedImage = UIApplication.shared.captureEntireWindow() else { return }
        
        let activityViewController = UIActivityViewController(activityItems: [capturedImage], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}
