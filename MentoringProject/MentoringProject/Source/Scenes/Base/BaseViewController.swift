//
//  BaseViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit
import Combine

class BaseViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func bindViewModel() {}
}
