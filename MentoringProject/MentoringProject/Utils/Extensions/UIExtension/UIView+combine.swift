//
//  UIView+combine.swift
//  YDShare
//
//  Created by wi_seong on 12/17/24.
//

import Combine
import UIKit

public extension UIView {
    var tapPublisher: AnyPublisher<Void, Never> {
        let tapGesture = UITapGestureRecognizer()
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true // 사용자 상호작용 활성화
        
        return Publishers.GesturePublisher(gestureRecognizer: tapGesture)
            .eraseToAnyPublisher()
    }
}

extension Publishers {
    struct GesturePublisher: Publisher {
        typealias Output = Void
        typealias Failure = Never
        
        private let gestureRecognizer: UIGestureRecognizer
        
        init(gestureRecognizer: UIGestureRecognizer) {
            self.gestureRecognizer = gestureRecognizer
        }
        
        func receive<S>(subscriber: S) where S : Subscriber, S.Input == Void, S.Failure == Never {
            let subscription = GestureSubscription(subscriber: subscriber, gestureRecognizer: gestureRecognizer)
            subscriber.receive(subscription: subscription)
        }
    }
    
    private final class GestureSubscription<S: Subscriber>: Subscription where S.Input == Void, S.Failure == Never {
        private var subscriber: S?
        private let gestureRecognizer: UIGestureRecognizer
        
        init(subscriber: S, gestureRecognizer: UIGestureRecognizer) {
            self.subscriber = subscriber
            self.gestureRecognizer = gestureRecognizer
            self.gestureRecognizer.addTarget(self, action: #selector(gestureRecognized))
        }
        
        func request(_ demand: Subscribers.Demand) {
            // Demand 처리: 이 경우, 아무것도 하지 않음
        }
        
        func cancel() {
            subscriber = nil
        }
        
        @objc private func gestureRecognized() {
            _ = subscriber?.receive(())
        }
    }
}
