//
//  DescriptionView.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

class DescriptionView: UIView {
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "불안한 사람들"
        label.textColor = .black
        label.font = UIFont.pretendard(type: .pretendardMedium, size: 13)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "프레드릭 베크만"
        label.textColor = .black
        label.font = UIFont.pretendard(type: .pretendardLight, size: 11)
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .iconLink
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDescriptionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupDescriptionView()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 56)
    }
    
    func setupDescriptionView() {
        backgroundColor = .gray200
        
        translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subTitleLabel)
        
        addSubview(imageView, autoLayout: [.trailing(20), .centerY(0)])
        addSubview(lineView, autoLayout: [.leading(0), .trailing(0), .top(0), .height(1)])
        addSubview(stackView, autoLayout: [.leading(20), .top(11), .bottom(11), .centerY(0)])
    }
}
