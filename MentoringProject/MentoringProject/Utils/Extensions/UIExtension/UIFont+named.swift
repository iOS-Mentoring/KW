//
//  UIFont+named.swift
//  YDUI
//
//  Created by 류연수 on 2/4/25.
//

import UIKit

public enum PretendardType: String {
    case pretendardRegular = "Pretendard-Regular"
    case pretendardThin = "Pretendard-Thin"
    case pretendardExtraLight = "Pretendard-ExtraLight"
    case pretendardLight = "Pretendard-Light"
    case pretendardMedium = "Pretendard-Medium"
    case pretendardSemiBold = "Pretendard-SemiBold"
    case pretendardBold = "Pretendard-Bold"
    case pretendardExtraBold = "Pretendard-ExtraBold"
    case pretendardBlack = "Pretendard-Black"

    public func font(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

public enum NanumMyeongjoType: String {
    case nanumMyeongjoOTF = "NanumMyeongjoOTF"
    case nanumMyeongjoOTFBold = "NanumMyeongjoOTFBold"
    case nanumMyeongjoOTFExtraBold = "NanumMyeongjoOTFExtraBold"

    public func font(size: CGFloat) -> UIFont {
        return UIFont(name: self.rawValue, size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

extension UIFont {
    
    static func pretendard(type: PretendardType, size: CGFloat) -> UIFont {
        type.font(size: size)
    }
    
    static func nanumMyeongjo(type: NanumMyeongjoType, size: CGFloat) -> UIFont {
        type.font(size: size)
    }
}
