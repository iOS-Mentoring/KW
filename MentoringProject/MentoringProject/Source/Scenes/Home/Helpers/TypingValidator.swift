//
//  TypingValidator.swift
//  MentoringProject
//
//  Created by PKW on 2/11/25.
//

import Foundation
import UIKit

class TypingValidator {
    private let placeholder: String
    
    init(placeholder: String) {
        self.placeholder = placeholder
    }
    
    func attributedValidation(for input: String) -> NSAttributedString {
        let result = NSMutableAttributedString(string: input)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        
        let baseAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.pretendard(type: .pretendardMedium, size: 20),
            .paragraphStyle: paragraphStyle, // ✅ 줄 간격 적용
            .foregroundColor: UIColor.gray300 // 기본 색상은 회색
        ]
        
        result.addAttributes(baseAttributes, range: NSRange(location: 0, length: result.length))
        
        let correctColor = UIColor.gray300 // 올바른 문자 색상
        let incorrectColor = UIColor.primaryRed // 틀린 문자 색상
        
        for (index, char) in input.enumerated() {
            let range = NSRange(location: index, length: 1)
            
            // 입력된 길이가 플레이스홀더보다 길면 이후 문자는 무시
            if index >= placeholder.count {
                continue
            }
            
            let placeholderIndex = placeholder.index(placeholder.startIndex, offsetBy: index)
            let targetChar = placeholder[placeholderIndex]
            
            if char == targetChar {
                result.addAttribute(.foregroundColor, value: correctColor, range: range)
            } else {
                result.addAttribute(.foregroundColor, value: incorrectColor, range: range)
            }
        }
        
        return result
    }
    
    func correctCharacterCount(for input: String) -> Int {
        var correctCount = 0
        
        for (index, char) in input.enumerated() {
            guard index < placeholder.count else { break }
            let placeholderIndex = placeholder.index(placeholder.startIndex, offsetBy: index)
            let correctChar = placeholder[placeholderIndex]
            
            if char == correctChar {
                correctCount += 1
            }
        }
        return correctCount
    }
}
