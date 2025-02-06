//
//  Publisher+extension.swift
//  YDShare
//
//  Created by wi_seong on 12/12/24.
//

import Combine

public extension Publisher {
    func withUnretained<O: AnyObject>(_ owner: O) -> Publishers.CompactMap<Self, (O, Self.Output)> {
        compactMap { [weak owner] output in
            owner == nil ? nil : (owner!, output)
        }
    }
}
