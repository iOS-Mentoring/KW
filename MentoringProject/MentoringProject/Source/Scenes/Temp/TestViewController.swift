//
//  TestViewController.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

class TestViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white

        let button = UIButton()
        button.setTitle("back", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.backButton), for: .touchUpInside)

        setLeftBarButtonItem(item: button)
    }

    @objc func backButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
