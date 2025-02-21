//
//  TypingSpeedCalculator.swift
//  MentoringProject
//
//  Created by PKW on 2/21/25.
//

import Foundation
import UIKit

/// 타이핑 속도를 계산하고 입력된 텍스트를 검사하는 클래스 입니다.
/// - 기능:
/// 1. CPM 계산
/// 2. 플레이스홀더 텍스트와 동일한 텍스트만 추출
/// 3. 입력된 텍스트를 플레이스홀더와 동일한지 비교하고 틀린 텍스트 강조
final class TypingCalculator {
    /// 사용자가 입력한 올바른 텍스트를 기반으로 CPM을 계산합니다.
    /// - Parameters:
    ///   - correctText: 올바르게 입력된 텍스트
    ///   - elapsedTime: 경과 시간
    /// - Returns: 1분당 입력한 문자 수
    func calculateCPM(correctText: String, elapsedTime: TimeInterval) -> Int {
        guard elapsedTime > 0 else { return 0 }
        
        let characterCount = correctText.count
        
        let cpm = Int(Double(characterCount) / elapsedTime * 60)
        
        return cpm
    }
    
    /// 사용자가 입력한 텍스트중 올바르게 입력한 텍스트만 추출합니다.
    /// - Parameters:
    ///   - inputText: 사용자가 입력한 텍스트
    ///   - placeholderText: 비교할 원본 텍스트
    /// - Returns: 올바르게 입력된 텍스트
    ///
    /// - Note:
    /// - 틀린 문자가 나오기 전까지의 문자열을 반환 합니다.
    func getCorrectCharacters(inputText: String, placeholderText: String) -> String {
        let inputCharacters = Array(inputText) // 입력한 문자 배열
        let placeholderCharacters = Array(placeholderText) // 플레이스홀더 문자 배열
        
        var correctCharacters = ""

        for (index, char) in inputCharacters.enumerated() {
            if index < placeholderCharacters.count, char == placeholderCharacters[index] {
                correctCharacters.append(char)
            } else {
                break
            }
        }
        return correctCharacters
    }
    
    /// 사용자가 입력한 텍스트를 원본 텍스트와 비교하여 올바른 문자는 black, 틀린 문자는 primaryRed으로 표시 합니다.
    /// - Parameters:
    ///   - inputText: 사용자가 입력한 텍스트
    ///   - placeholderText: 비교할 원본 텍스트
    /// - Returns: 틀린 부분이 강조된 NSAttributedString
    ///
    /// - Note:
    /// - 줄 간격 10
    /// - 틀린문자 primaryRed
    /// - 올바른 문자 black
    func getFormattedText(inputText: String, placeholderText: String) -> NSAttributedString {
        let inputCharacters = Array(inputText)
        let placeholderCharacters = Array(placeholderText)
        
        let attributedString = NSMutableAttributedString(string: inputText)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        
        for (index, char) in inputCharacters.enumerated() {
            let textColor: UIColor
            
            if index < placeholderCharacters.count, char == placeholderCharacters[index] {
                textColor = .black
            } else {
                textColor = .primaryRed
            }
            
            attributedString.addAttributes([
                .foregroundColor: textColor,
                .font: UIFont.pretendard(type: .pretendardMedium, size: 20)
            ], range: NSRange(location: index, length: 1))
        }
        
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
}
