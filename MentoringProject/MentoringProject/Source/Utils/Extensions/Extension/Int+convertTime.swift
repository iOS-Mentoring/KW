//
//  TimeInterval+convertTime.swift
//  MentoringProject
//
//  Created by PKW on 2/11/25.
//

import Foundation

extension Int {
    func formattedTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second] // 시, 분, 초
        formatter.zeroFormattingBehavior = .pad // 00 형식 유지
        formatter.unitsStyle = .positional // "hh:mm:ss" 형태로 변환
    
        return formatter.string(from: TimeInterval(self)) ?? "00:00:00"
    }
}
