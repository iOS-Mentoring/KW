//
//  UIImage+named.swift
//  YDUI
//
//  Created by 류연수 on 2/2/25.
//

import UIKit

public extension UIImage {
    static let iconBookmark = UIImage(named: "icon_bookmark")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    static let iconBookmarkFill = UIImage(named: "icon_bookmark_fill")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    static let iconClose = UIImage(named: "icon_close")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    static let iconDoubleQuotes = UIImage(named: "icon_double_quotes")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    static let iconInverseDownload = UIImage(named: "icon_inverse_download")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    static let iconInverseShare = UIImage(named: "icon_inverse_share")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    static let iconLink = UIImage(named: "icon_link")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    static let iconHistory = UIImage(named: "icon_history")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    static let iconLeftArrow = UIImage(named: "icon_left_arrow")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    
    static let illustHaruHalf = UIImage(named: "illust_haru_half")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    static let illustHaruWhole = UIImage(named: "illust_haru_whole")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
    
    static let crumpledWhitePaper = UIImage(named: "crumpled-white-paper")?.withRenderingMode(.alwaysOriginal) ?? UIImage()
}
