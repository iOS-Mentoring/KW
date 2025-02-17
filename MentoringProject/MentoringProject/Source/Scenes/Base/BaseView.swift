//
//  BaseView.swift
//  MentoringProject
//
//  Created by PKW on 2/17/25.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        configureLayout()
        configureView()
    }

    func configureLayout() {}
    func configureView() {}
}
