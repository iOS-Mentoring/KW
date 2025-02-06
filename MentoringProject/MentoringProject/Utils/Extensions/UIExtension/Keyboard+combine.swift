//
//  Keyboard+combine.swift
//  YDUI
//
//  Created by wi_seong on 12/27/24.
//

import UIKit
import Combine

public protocol CombineKeyboardType {
    var frame: AnyPublisher<CGRect, Never> { get }
    var visibleHeight: AnyPublisher<CGFloat, Never> { get }
    var willShowVisibleHeight: AnyPublisher<CGFloat, Never> { get }
    var isHidden: AnyPublisher<Bool, Never> { get }
}

public class CombineKeyboard: NSObject, CombineKeyboardType {

    // MARK: Public

    public static let shared = CombineKeyboard()

    public var frame: AnyPublisher<CGRect, Never>
    public var visibleHeight: AnyPublisher<CGFloat, Never>
    public var willShowVisibleHeight: AnyPublisher<CGFloat, Never>
    public var isHidden: AnyPublisher<Bool, Never>

    // MARK: Private

    private let frameSubject = CurrentValueSubject<CGRect, Never>(CGRect(
        x: 0,
        y: UIScreen.height,
        width: UIScreen.width,
        height: 0
    ))

    private var cancellables = Set<AnyCancellable>()
    private let panRecognizer = UIPanGestureRecognizer()

    // MARK: Initializing

    override private init() {
        frame = frameSubject.eraseToAnyPublisher()

        visibleHeight = frameSubject
            .map { UIScreen.main.bounds.intersection($0).height }
            .eraseToAnyPublisher()

        willShowVisibleHeight = visibleHeight
            .scan((visibleHeight: CGFloat(0), isShowing: false)) { lastState, newVisibleHeight in
                (visibleHeight: newVisibleHeight, isShowing: lastState.visibleHeight == 0 && newVisibleHeight > 0)
            }
            .filter { $0.isShowing }
            .map { $0.visibleHeight }
            .eraseToAnyPublisher()

        isHidden = visibleHeight
            .map { $0 == 0 }
            .removeDuplicates()
            .eraseToAnyPublisher()

        super.init()

        // Keyboard notifications
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .compactMap { notification -> CGRect? in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            }
            .map { frame -> CGRect in
                var adjustedFrame = frame
                if frame.origin.y < 0 {
                    adjustedFrame.origin.y = UIScreen.height - frame.height
                }
                return adjustedFrame
            }
            .sink { [weak self] frame in
                self?.frameSubject.send(frame)
            }
            .store(in: &cancellables)

        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .compactMap { notification -> CGRect? in
                (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            }
            .map { frame -> CGRect in
                var adjustedFrame = frame
                adjustedFrame.origin.y = UIScreen.height
                return adjustedFrame
            }
            .sink { [weak self] frame in
                self?.frameSubject.send(frame)
            }
            .store(in: &cancellables)

        // Pan gesture
        panRecognizer.publisher(for: \UIPanGestureRecognizer.state)
            .filter { $0 == .changed }
            .compactMap { [weak self] _ -> CGRect? in
                guard let self = self,
                      let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                      let window = windowScene.windows.first,
                      self.frameSubject.value.origin.y < UIScreen.height else {
                    return nil
                }
                let origin = self.panRecognizer.location(in: window)
                var newFrame = self.frameSubject.value
                newFrame.origin.y = max(origin.y, UIScreen.height - newFrame.height)
                return newFrame
            }
            .sink { [weak self] frame in
                self?.frameSubject.send(frame)
            }
            .store(in: &cancellables)

        // Gesture recognizer setup
        panRecognizer.delegate = self
        panRecognizer.maximumNumberOfTouches = 1

        NotificationCenter.default.publisher(for: UIApplication.didFinishLaunchingNotification)
            .sink { _ in
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    windowScene.windows.first?.addGestureRecognizer(self.panRecognizer)
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension CombineKeyboard: UIGestureRecognizerDelegate {

    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldReceive touch: UITouch
    ) -> Bool {
        let point = touch.location(in: gestureRecognizer.view)
        var view = gestureRecognizer.view?.hitTest(point, with: nil)
        while let candidate = view {
            if let scrollView = candidate as? UIScrollView,
               case .interactive = scrollView.keyboardDismissMode {
                return true
            }
            view = candidate.superview
        }
        return false
    }

    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        gestureRecognizer === self.panRecognizer
    }
}
