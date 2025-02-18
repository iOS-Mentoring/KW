//
//  ViewModelType.swift
//  MentoringProject
//
//  Created by PKW on 2/18/25.
//

import Combine
import Foundation

// 참고 사이트
// https://dev-workplace.tistory.com/27

protocol BaseViewModelType {
    associatedtype Input // View -> ViewModel
    associatedtype Output // ViewModel -> View

    func transform(from input: Input) -> Output
//    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never>
}
