//
//  TypingSpeedCalculator.swift
//  MentoringProject
//
//  Created by PKW on 2/11/25.
//

import Foundation

class TypingSpeedCalculator {
    func calculateWPM(count: Int, elapsedTime: TimeInterval) -> Int {
        let minutes = max(elapsedTime, 1) / 60.0
        return Int(Double(count) / 1 / minutes)
    }
}
