//
//  HistoryViewModel.swift
//  MentoringProject
//
//  Created by PKW on 2/24/25.
//
import Combine
import Foundation

final class HistoryViewModel: BaseViewModelType {
    private var cancellables = Set<AnyCancellable>()
   
    private let calendarManager = CalendarManager()
    
    private var weekDates = [[Date]]() // 3주치 날짜 저장
    private var currentWeekStart: Date // 현재 날짜
    private var selectedIndexPath: IndexPath? // 선택한 셀의 인덱스 패스
    
    private var selectedDateSub = CurrentValueSubject<Date, Never>(Date())
    
    init() {
        let today = Date()
        currentWeekStart = calendarManager.getStartOfWeek(date: today)
        selectedDateSub.send(today)
        updateWeeks(for: currentWeekStart)
        
        // 현재 날짜의 인덱스 패스 저장하기
        if let todayIndexPath = getIndexPath(for: today) {
            selectedIndexPath = todayIndexPath
        }
    }
    
    struct Input {
        let dateSelected: AnyPublisher<Date, Never> // 날짜 선택
    }
    
    struct Output {
        let selectedDate: AnyPublisher<Date, Never> // 선택된 날짜가 포함된 한 주
    }
    
    func transform(from input: Input) -> Output {
        return Output(selectedDate: Empty().eraseToAnyPublisher())
    }
    
    // MARK: 캘린더 관련
    
    private func updateWeeks(for currentWeek: Date) {
        guard let previousWeekStart = calendarManager.getPreviousWeek(from: currentWeek), // -1주, +1주 날짜 가져오기
              let nextWeekStart = calendarManager.getNextWeek(from: currentWeek) else { return }
        
        let previousWeek = calendarManager.getWeekDates(startDate: calendarManager.getStartOfWeek(date: previousWeekStart)) // -1주
        let currentWeekDates = calendarManager.getWeekDates(startDate: currentWeek) // 현재 주
        let nextWeek = calendarManager.getWeekDates(startDate: calendarManager.getStartOfWeek(date: nextWeekStart)) // +1주
        
        weekDates = [previousWeek, currentWeekDates, nextWeek] // 배열에 -1주, 현재 주, +1주 데이터 저장
        currentWeekStart = currentWeek // 현재 날짜가 포함된 주
    }
    
    func getWeeks() -> [[Date]] {
        return weekDates
    }
    
    func getShortWeekday(for date: Date) -> String {
        return calendarManager.getShortWeekday(from: date)
    }
    
    func getDay(from date: Date) -> String {
        return "\(calendarManager.getDay(from: date))"
    }
    
    func isSelectedDate(date: Date) -> Bool {
        return calendarManager.isSelectedDate(date1: date, date2: selectedDateSub.value)
    }
    
    func moveToPreviousWeek() {
        if let newCurrent = calendarManager.getPreviousWeek(from: currentWeekStart) {
            updateWeeks(for: newCurrent)
        }
    }
    
    func moveToNextWeek() {
        if let newCurrent = calendarManager.getNextWeek(from: currentWeekStart) {
            updateWeeks(for: newCurrent)
        }
    }
    
    // MARK: 날짜 변경 관련
    
    // 선택한 날짜 가져오기
    func getDate(for indexPath: IndexPath) -> Date? {
        let weekIndex = indexPath.section // 섹션 0,1,2
        let dayIndex = indexPath.item % 7 // 날짜 인덱스 위치 0~6 [일, 월, 화, 수, 목, 금, 토]
        
        // 배열 범위를 벗어나지 않도록 안전한 접근
        guard weekDates.indices.contains(weekIndex),
              weekDates[weekIndex].indices.contains(dayIndex)
        else {
            return nil
        }
        
        return weekDates[weekIndex][dayIndex]
    }

    private func getIndexPath(for date: Date) -> IndexPath? {
        for (weekIndex, week) in weekDates.enumerated() {
            if let dayIndex = week.firstIndex(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
                return IndexPath(item: dayIndex, section: weekIndex)
            }
        }
        return nil
    }

    func setSelectedDate(_ date: Date) {
        selectedDateSub.send(date)
    }
    
    func getSelectedIndexPath() -> IndexPath? {
        return selectedIndexPath
    }
    
    func setSelectedIndexPath(indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
}
