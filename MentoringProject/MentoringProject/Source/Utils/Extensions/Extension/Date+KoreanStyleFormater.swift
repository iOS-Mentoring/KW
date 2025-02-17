//
//  Date+KoreanStyleFormater.swift
//  YDUI
//
//  Created by 류연수 on 12/27/24.
//

import Foundation

public extension Date {
    
    var toKoreanStyleDay: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR") // 한국어 로케일 설정
        dateFormatter.dateFormat = "MM월 dd일" // 원하는 포맷 설정
        return dateFormatter.string(from: self)
    }
    
    var toKoreanStyleTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR") // 한국어 로케일 설정
        dateFormatter.dateFormat = "HH시 mm분" // 원하는 포맷 설정
        return dateFormatter.string(from: self)
    }
}
