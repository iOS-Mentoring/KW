//
//  Combine+BehaviorSubject.swift
//  YDShare
//
//  Created by 류연수 on 12/22/24.
//

import Foundation
import Combine

public final class BehaviorSubject<Output, Failure> {
    private let subject: CurrentValueSubject<Output, Never>
    
    /// 현재 값
    public var value: Output {
        get { subject.value }
        set { subject.send(newValue) }
    }
    
    /// 초기화
    public init(_ value: Output) {
        self.subject = CurrentValueSubject(value)
    }
    
    /// 값 방출
    public func send(_ value: Output) {
        subject.send(value)
    }
    
    /// Publisher로 접근
    public func eraseToAnyPublisher() -> AnyPublisher<Output, Never> {
        subject.eraseToAnyPublisher()
    }
    
    /// 구독 추가
    public func sink(receiveValue: @escaping (Output) -> Void) -> AnyCancellable {
        subject.sink(receiveValue: receiveValue)
    }
}
