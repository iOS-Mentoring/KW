//
//  UIApplication+capture.swift
//  MentoringProject
//
//  Created by PKW on 2/19/25.
//

import Combine
import UIKit

// TODO: 나중에 분리하기
extension UIApplication {
    /// 현재 앱의 전체 윈도우를 캡처하여 UIImage로 반환
    func captureEntireWindow() -> UIImage? {
        guard let windowScene = connectedScenes
            .first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
            let window = windowScene.windows.first(where: { $0.isKeyWindow })
        else {
            return nil
        }

        let renderer = UIGraphicsImageRenderer(bounds: window.bounds)
        return renderer.image { _ in

            // 윈도우의 전체 뷰 계층을 캡처
            window.drawHierarchy(in: window.bounds, afterScreenUpdates: true)
        }
    }
}
