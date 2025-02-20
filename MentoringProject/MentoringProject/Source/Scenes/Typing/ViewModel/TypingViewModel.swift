//
//  HomeViewModel.swift
//  MentoringProject
//
//  Created by PKW on 2/6/25.
//

import Combine
import Foundation

final class TypingViewModel: BaseViewModelType {
    // 뷰 -> 뷰모델
    struct Input {
        let onViewDidLoad: AnyPublisher<Void, Never> // 필사 텍스트 받기
        let onTextViewTextChanged: AnyPublisher<String, Never> // 텍스트 뷰 텍스트 입력
    }

    // 뷰모델 -> 뷰
    struct Output {
        let placeholderTextUpdated: AnyPublisher<String, Never> // 텍스트 뷰 플레이스홀더 업데이트
        let elapsedTimeUpdated: AnyPublisher<Int, Never> // 타이머 업데이트
        let wpmUpdated: AnyPublisher<Int, Never> // WPM 업데이트
        let summaryViewPresented: AnyPublisher<Void, Never> // 결과 화면 이동
    }

    private let timerManager: TimerManager
    private let typingCalc: TypingSpeedCalculator // 이름 바꿔
    private var cancellables = Set<AnyCancellable>()

    private let elapsedTimeSub = CurrentValueSubject<Int, Never>(0)
    private let wpmSub = CurrentValueSubject<Int, Never>(0)
    private let currentTextSub = CurrentValueSubject<String, Never>("")
    private let placeholderTextSub = CurrentValueSubject<String, Never>("")

    private var screenHeight: CGFloat = 0

    init() {
        self.timerManager = TimerManager()
        self.typingCalc = TypingSpeedCalculator()
    }

    func transform(from input: Input) -> Output {
        // PassthroughSubject 서브젝트들은 언제 사용해야하지?
        let showSummaryView = PassthroughSubject<Void, Never>()

        // 서버에서 받아오는 방식?으로 플레이스홀더 텍스트 적용
        let updatePlaceholder = input.onViewDidLoad
            .flatMap { [weak self] _ -> AnyPublisher<String, Never> in
                guard let self = self else {
                    return Just("텍스트를 가져오지 못했습니다.").eraseToAnyPublisher()
                }
                return Future(asyncFunc: self.testViewDidLoad)
                    .handleEvents(receiveOutput: { text in
                        self.placeholderTextSub.send(text) // 텍스트 저장
                    })
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()

        // 첫글자 입력시 타이머 시작
        let startTimer = input.onTextViewTextChanged
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

                let wpm = self.typingCalc.calculateWPM(count: currentTextSub.value.count, elapsedTime: TimeInterval(seconds))

                self.elapsedTimeSub.send(seconds)
                self.wpmSub.send(wpm)
            }
            .store(in: &cancellables)

        // 텍스트 입력시 WPM 업데이트
        input.onTextViewTextChanged
            .sink { [weak self] text in
                guard let self = self else { return }
                self.currentTextSub.send(text)

                let wpm = self.typingCalc.calculateWPM(count: text.count, elapsedTime: TimeInterval(self.timerManager.getCount()))
                self.wpmSub.send(wpm)
            }
            .store(in: &cancellables)

        // 글자 다 입력하면
        currentTextSub
            .combineLatest(placeholderTextSub)
            .filter { !$0.0.isEmpty && $0.0 == $0.1 }
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.timerManager.stop()
                showSummaryView.send()
            }
            .store(in: &cancellables)

        return Output(placeholderTextUpdated: updatePlaceholder,
                      elapsedTimeUpdated: elapsedTimeSub.eraseToAnyPublisher(),
                      wpmUpdated: wpmSub.eraseToAnyPublisher(),
                      summaryViewPresented: showSummaryView.eraseToAnyPublisher())
    }

    func testViewDidLoad() async throws -> String {
        try await Task.sleep(nanoseconds: 500_000_000) // 0.5초 지연
//        return "1111"
        return "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다.어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다."
    }
}
