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
        stackView.spacing = 5
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private let selectionBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.backgroundColor = .black
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private let selectionDot: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
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
        
        dateLabel.text = nil
        
        selectionBackgroundView.backgroundColor = .clear
        selectionDot.backgroundColor = .clear
    }
    
    func configurLayout() {
        selectionBackgroundView.addSubview(dateLabel, autoLayout: [.centerX(0), .centerY(0)])
        selectionBackgroundView.autoLayout([.width(30), .height(30)])
        
        stackView.addArrangedSubview(selectionBackgroundView)
        
        selectionDot.autoLayout([.width(4), .height(4)])
        stackView.addArrangedSubview(selectionDot)
        
        contentView.addSubview(stackView, autoLayout: [.leading(0), .trailing(0), .top(0), .bottom(0)])
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
    }
    
    func configurData(day: String, isSelected: Bool, isDot: Bool) {
        dateLabel.setStyledText(text: day,
                                font: .pretendard(type: .pretendardBold, size: 14),
                                lineHeight: 12,
                                letterSpacing: -0.056,
                                textAlignment: .center)
        
        selectionBackgroundView.backgroundColor = isSelected ? UIColor.gray200 : .clear
        selectionDot.backgroundColor = isDot ? .black : .clear
    }
}
