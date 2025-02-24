//
//  CalendarManager.swift
//  MentoringProject
//
//  Created by PKW on 2/24/25.
//

import Foundation

// 날짜 계산만 담당하도록
struct CalendarManager {
    private let calendar = Calendar(identifier: .gregorian)
    
    // 특정 날짜가 포함된 한 주
    func getStartOfWeek(date: Date) -> Date {
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return calendar.date(from: components) ?? date
    }
    
    // 일 월 화 수 목 금 토 일
    func getWeekDates(startDate: Date) -> [Date] {
        return (0 ..< 7).compactMap { calendar.date(byAdding: .day, value: $0, to: startDate) }
    }
    
    // 영어로 요일 변환
    func getShortWeekday(from date: Date) -> String {
        let weekdaySymbols = calendar.shortWeekdaySymbols
        let weekdayIndex = calendar.component(.weekday, from: date) - 1
        return weekdaySymbols[weekdayIndex]
    }
    
    // 날짜
    func getDay(from date: Date) -> Int {
        return calendar.component(.day, from: date)
    }
    
    // 날짜 비교
    func isSelectedDate(date1: Date, date2: Date) -> Bool {
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    // 이전 주
    func getPreviousWeek(from currentStartDate: Date) -> Date? {
        return calendar.date(byAdding: .day, value: -7, to: currentStartDate)
    }
    
    // 다음 주
    func getNextWeek(from currentStartDate: Date) -> Date? {
        return calendar.date(byAdding: .day, value: 7, to: currentStartDate)
    }
}
