//
//  SummaryReferenceView.swift
//  MentoringProject
//
//  Created by PKW on 2/17/25.
//

import UIKit

final class SummaryReferenceView: BaseView {
    private let baseReferenceView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let doubleQuotesImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.frame = .init(x: 0, y: 0, width: 24, height: 24)
        imageView.image = .iconDoubleQuotes
        return imageView
    }()
    
    private let typingStrLabel: UILabel = {
        let label = UILabel()
        label.text = "어른이 되는 것이 끔찍한 이유는 아무도 우리에게 관심이 없고, 앞으로는 스스로 모든 일을 처리하고 세상이 어떤 식으로 돌아가는지 파악해야 한다는 것을 깨닫는 순간이 찾아오기 때문이다. "
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        let lineheight = 28.0
        paragraphStyle.minimumLineHeight = lineheight
        paragraphStyle.maximumLineHeight = lineheight
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.pretendard(type: .pretendardRegular, size: 18),
            .paragraphStyle: paragraphStyle,
            .kern: -0.04 * 18
        ]
        
        if let text = label.text {
            label.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
    
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "불안한 사람들"
        label.font = .pretendard(type: .pretendardSemiBold, size: 16)
        label.textColor = .primaryEmphasis
        return label
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.text = "프레드릭 베크만"
        label.font = .pretendard(type: .pretendardRegular, size: 12)
        label.textColor = .primaryEmphasis
        return label
    }()
    
    override func configureLayout() {
        addSubview(baseReferenceView, autoLayout: [.leading(0),. trailing(0), .top(0), .bottom(0)])
        baseReferenceView.addSubview(doubleQuotesImageView, autoLayout: [.leading(20), .top(40), .trailingLessThan(20)])
        baseReferenceView.addSubview(typingStrLabel, autoLayout: [.leading(20), .trailing(20),. topNext(to: doubleQuotesImageView, constant: 20)])
        baseReferenceView.addSubview(titleLabel, autoLayout: [.leading(20), .trailing(20),. topNext(to: typingStrLabel, constant: 30)])
        baseReferenceView.addSubview(authorLabel, autoLayout: [.leading(20), .trailing(20),. topNext(to: titleLabel, constant: 6), .bottom(110)])
    }
}
