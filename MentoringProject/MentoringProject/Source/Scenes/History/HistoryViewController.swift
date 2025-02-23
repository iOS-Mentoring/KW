//
//  TestViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

class HistoryViewController: BaseViewController {
    private let rootView = HistoryView()

    override func loadView() {
        self.view = self.rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "하루 보관함"
    }
}
