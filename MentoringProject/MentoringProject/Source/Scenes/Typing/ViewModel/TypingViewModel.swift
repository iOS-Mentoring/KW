//
//  HomeViewModel.swift
//  MentoringProject
//
//  Created by PKW on 2/6/25.
//

import Combine
import Foundation

final class TypingViewModel: BaseViewModelType {
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never> // 필사 텍스트 받기
        let textViewDidChanged: AnyPublisher<String, Never> // 텍스트 뷰 텍스트 입력
    }

    struct Output {
        let updatePlaceholder: AnyPublisher<String, Never> // 텍스트 뷰 플레이스홀더 업데이트
        let updateElapsedTime: AnyPublisher<Int, Never> // 타이머 업데이트
        let updateWPMText: AnyPublisher<Int, Never> // WPM 업데이트
        let showSummaryView: AnyPublisher<Void, Never> // 결과 화면 이동
    }

    private let timerManager: TimerManager
    private let typingCalc: TypingSpeedCalculator
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.timerManager = TimerManager()
        self.typingCalc = TypingSpeedCalculator()
    }

    func transform(from input: Input) -> Output {
        let elapsedTimeSub = PassthroughSubject<Int, Never>()
        let updateWPMTextSub = PassthroughSubject<Int, Never>()
        let currentText = CurrentValueSubject<String, Never>("")
        let placeholderText = CurrentValueSubject<String, Never>("")
        let showSummaryView = PassthroughSubject<Void, Never>()

        // 서버에서 받아오는 방식?으로 플레이스홀더 텍스트 적용
        let updatePlaceholder = input.viewDidLoad
            .flatMap { [weak self] _ -> AnyPublisher<String, Never> in
                guard let self = self else {
                    return Just("텍스트를 가져오지 못했습니다.").eraseToAnyPublisher()
                }
                return Future(asyncFunc: self.testViewDidLoad)
                    .handleEvents(receiveOutput: { text in
                        placeholderText.send(text) // 텍스트 저장
                    })
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()

        // 첫글자 입력시 타이머 시작
        let startTimer = input.textViewDidChanged
            .filter { !$0.isEmpty }
            .first()
            .flatMap { [weak self] _ -> AnyPublisher<Int, Never> in
                guard let self else { return Empty().eraseToAnyPublisher() }
                return self.timerManager.start()
            }
            .eraseToAnyPublisher()

        // 1초마다 경과 시간 업데이트, WPM도 다시 업데이트
        startTimer
            .sink { [weak self] seconds in
                guard let self = self else { return }
                let wpm = self.typingCalc.calculateWPM(count: currentText.value.count, elapsedTime: TimeInterval(seconds))

                elapsedTimeSub.send(seconds)
                updateWPMTextSub.send(wpm)
            }
            .store(in: &cancellables)

        // 텍스트 입력시 WPM 업데이트
        input.textViewDidChanged
            .sink { [weak self] text in
                guard let self = self else { return }
                currentText.send(text)
                
                let wpm = self.typingCalc.calculateWPM(count: text.count, elapsedTime: TimeInterval(self.timerManager.getCount()))
                updateWPMTextSub.send(wpm)
            }
            .store(in: &cancellables)

        // 글자 다 입력하면 업데이트
        currentText
            .combineLatest(placeholderText)
            .filter { !$0.0.isEmpty && $0.0 == $0.1 }
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.timerManager.stop()
                showSummaryView.send()
            }
            .store(in: &cancellables)
        
        return Output(updatePlaceholder: updatePlaceholder,
                      updateElapsedTime: elapsedTimeSub.eraseToAnyPublisher(),
                      updateWPMText: updateWPMTextSub.eraseToAnyPublisher(),
                      showSummaryView: showSummaryView.eraseToAnyPublisher())
    }

    func testViewDidLoad() async throws -> String {
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5초 지연
        return "11112222"
//        return "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다."
    }
}
