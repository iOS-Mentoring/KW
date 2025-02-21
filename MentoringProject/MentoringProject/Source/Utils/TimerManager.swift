//
//  TimerManager.swift
//  MentoringProject
//
//  Created by PKW on 2/21/25.
//

import Combine
import Foundation

protocol TimerManagerProtocol {
    func start() -> AnyPublisher<Int, Never>
    func stop()
    func getCount() -> Int
}

final class TimerManager: TimerManagerProtocol {
    private var timerCancellable: AnyCancellable?
    private let timerSubject = PassthroughSubject<Int, Never>()
    private var count = 0
    private let maxTime = 60

    func start() -> AnyPublisher<Int, Never> {
        count = 0 // 카운트 초기화
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .prefix(maxTime)
            .sink(receiveCompletion: { [weak self] _ in
                guard let self = self else { return }
                self.stop() // 60초면 타이머 종료
            }, receiveValue: { [weak self] _ in
                guard let self = self else { return }
                self.count += 1 // 타이머 1초씩 증가
                self.timerSubject.send(self.count) // 증가된 타이머 방출
            })

        return timerSubject.eraseToAnyPublisher()
    }

    func stop() {
        print("타이머 종료 합니다.")
        timerCancellable?.cancel()
        timerCancellable = nil
        timerSubject.send(completion: .finished) // 종료
    }

    func getCount() -> Int {
        return count
    }
}
