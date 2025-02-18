//
//  DescriptionView.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

final class DescriptionView: BaseView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 2
        return stackView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "불안한 사람들"
        label.textColor = .black
        label.font = UIFont.pretendard(type: .pretendardMedium, size: 13)
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "프레드릭 베크만"
        label.textColor = .black
        label.font = UIFont.pretendard(type: .pretendardLight, size: 11)
        return label
    }()

    let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    let linkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.iconLink, for: .normal)
        return button
    }()

    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 56)
    }

    override func configureLayout() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)

        addSubview(linkButton, autoLayout: [.trailing(20), .top(11), .bottom(12)])
        addSubview(stackView, autoLayout: [.leading(20), .top(11), .bottom(12), .trailingEqualLessThan(to: linkButton, constant: 20)])
        addSubview(borderView, autoLayout: [.leading(0), .trailing(0), .top(0), .height(1)])
    }

    override func configureView() {
        backgroundColor = .gray200
    }
}
