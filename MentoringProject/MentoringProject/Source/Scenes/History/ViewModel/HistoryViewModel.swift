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
    
    struct Input {
        let dateSelected: AnyPublisher<Date, Never> // 날짜 선택
    }
    
    struct Output {
        let selectedDate: AnyPublisher<Date, Never> // 선택된 날짜가 포함된 한 주
    }
    
    init() {
        let today = Date()
        let startOfWeek = calendarManager.getStartOfWeek(date: today)
        weekDates = calendarManager.getWeekDates(startDate: startOfWeek)
        selectedDateSubject.send(today)
        
        updateSelectedIndexPath(for: today)
    }
    
    private var weekDates = [Date]() // 현재 날짜가 포함된 한 주 서브젝트
    private var selectedIndexPath: IndexPath? // 선택된 날짜 인덱스패스
    
    private let selectedDateSubject = CurrentValueSubject<Date, Never>(Date()) // 선택한 날짜 서브젝트
    
    func transform(from input: Input) -> Output {
        input.dateSelected
            .sink { [weak self] selectedDate in
                guard let self = self else { return }
                self.selectedDateSubject.send(selectedDate)
            }
            .store(in: &cancellables)
        
        return Output(selectedDate: selectedDateSubject.eraseToAnyPublisher())
    }
    
    // MARK: 캘린더 뷰 컬렉션 뷰 추가 기능

    func updateSelectedIndexPath(for date: Date) {
        if let index = weekDates.firstIndex(where: { calendarManager.isSelectedDate(date1: $0, date2: date) }) {
            selectedIndexPath = IndexPath(item: index, section: 0)
        }
    }
    
    func getSelectedIndexPath() -> IndexPath? {
        return selectedIndexPath
    }
    
    // MARK: 캘린더 기능

    func getWeekDates() -> [Date] {
        return weekDates
    }
    
    func getShortWeekday(for date: Date) -> String {
        return calendarManager.getShortWeekday(from: date)
    }
    
    func getDay(from date: Date) -> String {
        return "\(calendarManager.getDay(from: date))"
    }
    
    func isSelectedDate(_ date: Date) -> Bool {
        return calendarManager.isSelectedDate(date1: selectedDateSubject.value, date2: date)
    }
    
    func getSelectedDate() -> Date {
        return selectedDateSubject.value
    }
    
    // MARK:
}
