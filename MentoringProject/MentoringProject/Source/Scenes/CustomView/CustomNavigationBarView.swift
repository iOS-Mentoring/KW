//
//  CustomNavigationBarView.swift
//  MentoringProject
//
//  Created by PKW on 2/7/25.
//

import UIKit

class CustomNavigationBarView: UIView {
    
    // 제목 라벨
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.nanumMyeongjo(type: .nanumMyeongjoOTF, size: 22)
        return label
    }()
    
    // 왼쪽 버튼들을 담을 스택뷰
    let leftStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    // 오른쪽 버튼들을 담을 스택뷰
    let rightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .white
        
        self.addSubview(titleLabel, autoLayout: [.centerX(0), .centerY(0)])
        self.addSubview(leftStackView, autoLayout: [.leading(16), .centerY(0)])
        self.addSubview(rightStackView, autoLayout: [.trailing(16), .centerY(0)])
    }
}
