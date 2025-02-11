//
//  TimerManager.swift
//  MentoringProject
//
//  Created by PKW on 2/11/25.
//

import Combine
import Foundation

class TimerManager {
    @Published var elapsedTime: TimeInterval = 0
    private var timerCancellable: AnyCancellable?

    func start() {
        stop()
        elapsedTime = 0

        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.elapsedTime += 1
            }
    }

    func stop() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
}
