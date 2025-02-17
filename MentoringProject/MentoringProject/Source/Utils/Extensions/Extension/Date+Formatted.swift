//
//  Date+Formatted.swift
//  YDShare
//
//  Created by wi_seong on 12/16/24.
//

import Foundation

public extension Date {

    func formattedDateString(dateFormat: String, localeIdentifier: String = "en_US_POSIX", timeZone: TimeZone? = TimeZone(identifier: "Asia/Seoul")) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = dateFormat
        formatter.locale = Locale(identifier: localeIdentifier)
        return formatter.string(from: self)
    }

    func isSameDate(to: Date, timeZone: TimeZone? = TimeZone(identifier: "Asia/Seoul")) -> Bool {
        let dateFormat = "yyyy-MM-dd"
        let fromTimeInKoreaString = self.formattedDateString(dateFormat: dateFormat, timeZone: timeZone)
        let toTimeInKoreaString = to.formattedDateString(dateFormat: dateFormat, timeZone: timeZone)

        return fromTimeInKoreaString == toTimeInKoreaString
    }
}
