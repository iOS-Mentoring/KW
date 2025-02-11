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
        let correctColor = UIColor.gray // 올바른 문자 색상
        let incorrectColor = UIColor.red // 틀린 문자 색상
        
        // 입력 문자열과 플레이스홀더를 인덱스별로 비교
        for (index, char) in input.enumerated() {
            // 만약 입력된 길이가 플레이스홀더보다 길면, 그 이후의 문자는 모두 잘못된 것으로 처리
            if index >= placeholder.count {
                let range = NSRange(location: index, length: 1)
                result.addAttribute(.foregroundColor, value: incorrectColor, range: range)
                continue
            }
            
            // 플레이스홀더의 해당 인덱스의 문자 가져오기
            let placeholderIndex = placeholder.index(placeholder.startIndex, offsetBy: index)
            let targetChar = placeholder[placeholderIndex]
            let range = NSRange(location: index, length: 1)
            
            // 비교 후 색상 지정
            if char == targetChar {
                result.addAttribute(.foregroundColor, value: correctColor, range: range)
            } else {
                result.addAttribute(.foregroundColor, value: incorrectColor, range: range)
            }
        }
        return result
    }
}
