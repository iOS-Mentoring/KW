//
//  UITextView+estimatedSize.swift
//  YDUI
//
//  Created by 류연수 on 12/14/24.
//

import UIKit

public extension UITextView {
    
    var estimatedHeight: CGFloat {
        // textView의 textContainer에 맞는 사이즈를 계산
        let textContainer = self.textContainer
        let layoutManager = self.layoutManager
        
        // textContainer의 패딩을 제거하고 계산
        layoutManager.ensureLayout(for: textContainer)
        
        // 컨텐츠의 전체 범위를 계산
        let estimatedBoundingRect = layoutManager.usedRect(for: textContainer)
        
        return estimatedBoundingRect.height + textContainerInset.top + textContainerInset.bottom
    }

    var estimatedWidth: CGFloat {
        // textView의 textContainer에 맞는 사이즈를 계산
        let textContainer = self.textContainer
        let layoutManager = self.layoutManager

        // textContainer의 패딩을 제거하고 계산
        layoutManager.ensureLayout(for: textContainer)

        // 컨텐츠의 전체 범위를 계산
        let estimatedBoundingRect = layoutManager.usedRect(for: textContainer)

        return estimatedBoundingRect.width + textContainerInset.left + textContainerInset.right
    }
}


