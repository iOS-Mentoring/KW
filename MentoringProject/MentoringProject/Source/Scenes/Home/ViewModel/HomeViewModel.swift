//
//  HomeViewModel.swift
//  MentoringProject
//
//  Created by PKW on 2/6/25.
//

import Combine
import Foundation

final class HomeViewModel: ObservableObject {
    @Published var inputStr: String = ""
    @Published var attributedStr: NSAttributedString = NSAttributedString(string: "")
    @Published var typingSpeed: TypingSpeedModel = TypingSpeedModel(characterCount: 0, wpm: 0)
    @Published var elapsedTime: TimeInterval = 0
    
    let typingStr: String = "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다."
    
    private let timerManager = TimerManager()
    private let calculator = TypingSpeedCalculator()
    private let typingValidator: TypingValidator
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        typingValidator = TypingValidator(placeholder: typingStr)
        bindUserInput()
    }
    
    private func bindUserInput() {
        // 타이머 시작하기
        $inputStr
            .filter { !$0.isEmpty }
            .first()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.timerManager.start()
            }
            .store(in: &cancellables)
        
        Publishers.CombineLatest($inputStr, timerManager.$elapsedTime)
            .sink { [weak self] input, elapsed in
                guard let self = self else { return }
                let correctCount = self.typingValidator.correctCharacterCount(for: input)
                let computedWPM = self.calculator.calculateWPM(count: correctCount, elapsedTime: elapsed)
                self.typingSpeed = TypingSpeedModel(characterCount: correctCount, wpm: computedWPM)
                
                print("입력된 문자 수: \(correctCount), 경과 시간: \(elapsed)초, WPM: \(computedWPM)")
            }
            .store(in: &cancellables)
        
        timerManager.$elapsedTime
            .assign(to: \.elapsedTime, on: self)
            .store(in: &cancellables)
        
        
        $inputStr
            .map { [weak self] input -> NSAttributedString in
                guard let self = self else { return NSAttributedString(string: input) }
                return self.typingValidator.attributedValidation(for: input)
            }
            .assign(to: \.attributedStr, on: self)
            .store(in: &cancellables)
    }
}
