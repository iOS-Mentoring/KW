//
//  SaveImageManager.swift
//  MentoringProject
//
//  Created by PKW on 2/26/25.
//

import Foundation
import UIKit
import Combine

final class SaveImageManager: NSObject {
    static let shared = SaveImageManager()
    private override init() { }
    
    private let imageSaveSub = PassthroughSubject<Bool, Error>()
    
    func saveImage(image: UIImage) -> AnyPublisher<Bool, Error> {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(ImageSaved(image:error:contentInfo:)), nil)
        return imageSaveSub.eraseToAnyPublisher()
    }
    
    @objc private func ImageSaved(image: UIImage, error: Error?, contentInfo: UnsafeRawPointer?) {
        if let error = error {
            imageSaveSub.send(completion: .failure(error))
        } else {
            imageSaveSub.send(true)
            imageSaveSub.send(completion: .finished)
        }
    }
}
