//
//  CalendarCell.swift
//  MentoringProject
//
//  Created by PKW on 2/23/25.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    static let reuseIdentifier = "CalendarCell"
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()
    
    private let selectionBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = .black
        return view
    }()
    
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Mon"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "30"
        return label
    }()
    
    private let selectionDot: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 2
        view.isHidden = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configurLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurLayout() {
        selectionBackgroundView.addSubview(dateLabel, autoLayout: [.centerX(0), .centerY(0)])
        selectionBackgroundView.autoLayout([.width(30), .height(30)])
        
        stackView.addArrangedSubview(dayLabel)
        stackView.setCustomSpacing(11, after: dayLabel)
        stackView.addArrangedSubview(selectionBackgroundView)
        stackView.setCustomSpacing(5, after: selectionBackgroundView)
        
        selectionDot.autoLayout([.width(4), .height(4)])
        stackView.addArrangedSubview(selectionDot)
        
        contentView.addSubview(stackView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
    }
    
    func configureView() {
        contentView.backgroundColor = .blue
    }
}
