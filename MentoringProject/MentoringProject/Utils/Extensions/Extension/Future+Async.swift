//
//  Future+Async.swift
//  YDRealm
//
//  Created by wi_seong on 12/17/24.
//

import Combine

public extension Future where Failure == Never {
    convenience init(asyncFunc: @escaping () async throws -> Output) {
        self.init { promise in
            Task {
                do {
                    let result = try await asyncFunc()
                    promise(.success(result))
                } catch {
//                    dump(error)
                }
            }
        }
    }
}
