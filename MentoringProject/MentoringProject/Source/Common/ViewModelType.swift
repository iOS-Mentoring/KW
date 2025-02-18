//
//  ViewModelType.swift
//  MentoringProject
//
//  Created by PKW on 2/18/25.
//

import Combine
import Foundation

protocol ViewModelType {
    associatedtype Input // View -> ViewModel
    associatedtype Output // ViewModel -> View

    func transform(input: AnyPublisher<Input, Never>) -> AnyPublisher<Output, Never>
}
