//
//  CalendarCell.swift
//  MentoringProject
//
//  Created by PKW on 2/23/25.
//

import UIKit

final class CalendarCell: UICollectionViewCell {
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
        label.textColor = .black
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let selectionDot: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 2
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        dayLabel.text = nil
        dayLabel.textColor = .black
        
        dateLabel.text = nil
        
        selectionBackgroundView.backgroundColor = .clear
        selectionDot.backgroundColor = .clear
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
        contentView.backgroundColor = .clear
    }
    
    func configurData(dayOfWeek: String, day: String, isSelected: Bool) {
        dayLabel.setStyledText(text: dayOfWeek,
                               font: .pretendard(type: .pretendardRegular, size: 10),
                               letterSpacing: -0.4,
                               textAlignment: .center)
        
        dateLabel.setStyledText(text: day,
                                font: .pretendard(type: .pretendardBold, size: 14),
                                letterSpacing: -0.56,
                                textAlignment: .center)
        
        selectionBackgroundView.backgroundColor = isSelected ? UIColor.gray200 : .clear
        selectionDot.backgroundColor = isSelected ? .black : .clear
    }
    
    func setDayLabelColor() {
        dayLabel.textColor = .red
    }
}
