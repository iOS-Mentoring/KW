//
//  Collection+Index.swift
//  YDShare
//
//  Created by wi_seong on 12/25/24.
//

import Foundation

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
