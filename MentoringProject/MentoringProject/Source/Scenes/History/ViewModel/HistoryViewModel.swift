//
//  HistoryViewModel.swift
//  MentoringProject
//
//  Created by PKW on 2/24/25.
//
import Combine
import Foundation

final class HistoryViewModel: BaseViewModelType {
    private let calendarManager = CalendarManager()
    
    private var cancellables = Set<AnyCancellable>()
    private let selectedDateSubject = CurrentValueSubject<Date?, Never>(nil) // 선택한 날짜 서브젝트
    private let scrollPageSubject = PassthroughSubject<Void, Never>() // 컬렉션뷰 스크롤 서브젝트
    
    private var weekDates = [[Date]]() // -1주, 현재주, +1주 배열
    private var currentWeekStart: Date // 이번주 시작 날짜 (일요일이 몇일인지)
    
    init() {
        let today = Date()
        currentWeekStart = calendarManager.getStartOfWeek(date: today) // 이번주 시작 날짜 가져오기
        updateWeeks(for: currentWeekStart) // -1,현재,+1 날짜 가져오기
        selectedDateSubject.send(today)
    }
    
    struct Input {
        let viewDidLoad: AnyPublisher<Void, Never>
        let cellTapped: AnyPublisher<IndexPath?, Never>
        let scrollPageChanged: AnyPublisher<Int, Never>
    }
    
    struct Output {
        let historyDataUpdated: AnyPublisher<HistoryModel?, Never>
        let weeksUpdated: AnyPublisher<Void, Never>
    }
    
    func transform(from input: Input) -> Output {
        let initialData = input.viewDidLoad
            .map { [weak self] _ -> HistoryModel? in
                guard let self = self,
                      let date = self.selectedDateSubject.value else { return nil }
                
                let timeInterval = date.convertDateToTimeInterval()
                let data = HistoryMockData.data[timeInterval]
                
                return data
            }
            .eraseToAnyPublisher()
        
        let cellTappedData = input.cellTapped
            .map { [weak self] indexPath -> HistoryModel? in
                guard let self = self, let indexPath = indexPath else { return nil }
                
                let date = getDate(for: indexPath) ?? Date()
                let timeInterval = date.convertDateToTimeInterval()
                let data = HistoryMockData.data[timeInterval]
                
                self.selectedDateSubject.send(date)
                return data
            }
            .eraseToAnyPublisher()
        
        let historyDataUpdated = initialData.merge(with: cellTappedData).eraseToAnyPublisher()
        
        // 스크롤했을때 페이지 방출
        input.scrollPageChanged
            .sink { [weak self] page in
                guard let self = self else { return }
                
                if page == 0 {
                    self.moveToPreviousWeek()
                } else if page == 2 {
                    self.moveToNextWeek()
                }
                
                scrollPageSubject.send()
            }
            .store(in: &cancellables)
        
        return Output(historyDataUpdated: historyDataUpdated,
                      weeksUpdated: scrollPageSubject.eraseToAnyPublisher())
    }
    
    // MARK: 캘린더 날짜 계산 관련

    private func updateWeeks(for currentWeek: Date) {
        guard let previousWeekStart = calendarManager.getPreviousWeek(from: currentWeek), // -1주, +1주 날짜 가져오기
              let nextWeekStart = calendarManager.getNextWeek(from: currentWeek) else { return }
        
        let previousWeek = calendarManager.getWeekDates(startDate: calendarManager.getStartOfWeek(date: previousWeekStart)) // -1주
        let currentWeekDates = calendarManager.getWeekDates(startDate: currentWeek) // 현재 주
        let nextWeek = calendarManager.getWeekDates(startDate: calendarManager.getStartOfWeek(date: nextWeekStart)) // +1주
        
        weekDates = [previousWeek, currentWeekDates, nextWeek] // 배열에 -1주, 현재 주, +1주 데이터 저장
        currentWeekStart = currentWeek // 일주일 시작 날짜 업데이트
    }
    
    // -1주로 이동
    private func moveToPreviousWeek() {
        if let newCurrent = calendarManager.getPreviousWeek(from: currentWeekStart) {
            updateWeeks(for: newCurrent)
        }
    }
    
    // +1주로 이동
    private func moveToNextWeek() {
        if let newCurrent = calendarManager.getNextWeek(from: currentWeekStart) {
            updateWeeks(for: newCurrent)
        }
    }
    
    // MARK: 캘린더 날짜 설정 관련
    
    // 날짜가 저장된 배열 가져오기
    func getWeeks() -> [[Date]] {
        return weekDates
    }
    
    // 셀에 표시할 날짜 가져오기
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
    
    // 날짜 문자열로 변환
    func convertDayToString(date: Date) -> String {
        return "\(calendarManager.convertDateToDay(from: date))"
    }
    
    func isSelectedDate(date: Date) -> Bool {
        guard let currentDate = selectedDateSubject.value else { return false }
        return calendarManager.isSelectedDate(date1: currentDate, date2: date)
    }
    
    func hasData(date: Date) -> Bool {
        let timeInterval = date.convertDateToTimeInterval()
        return HistoryMockData.data[timeInterval] != nil
    }
}

extension Date {
    func convertDateToTimeInterval() -> Double {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: self)
        return startOfDay.timeIntervalSince1970 + 32400
    }
}

extension String {
    func toFormattedDate() -> String? {
        guard let timestamp = Double(self) else { return nil }
        let date = Date(timeIntervalSince1970: timestamp)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        return formatter.string(from: date)
    }
}
