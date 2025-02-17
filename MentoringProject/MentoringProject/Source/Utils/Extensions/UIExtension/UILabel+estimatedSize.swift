//
//  UILabel+estimatedSize.swift
//  YDUI
//
//  Created by 류연수 on 12/14/24.
//

import UIKit

public extension UILabel {
    
    var deepCopy: UILabel {
        let copiedLabel: UILabel = .init()
        
        copiedLabel.text = text
        copiedLabel.font = font
        copiedLabel.textColor = textColor
        copiedLabel.shadowColor = shadowColor
        copiedLabel.shadowOffset = shadowOffset
        copiedLabel.textAlignment = textAlignment
        copiedLabel.lineBreakMode = lineBreakMode
        copiedLabel.numberOfLines = numberOfLines
        copiedLabel.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        copiedLabel.minimumScaleFactor = minimumScaleFactor
        copiedLabel.allowsDefaultTighteningForTruncation = allowsDefaultTighteningForTruncation
        copiedLabel.isUserInteractionEnabled = isUserInteractionEnabled
        copiedLabel.isEnabled = isEnabled
        copiedLabel.backgroundColor = backgroundColor
        copiedLabel.alpha = alpha
        copiedLabel.isOpaque = isOpaque
        copiedLabel.clearsContextBeforeDrawing = clearsContextBeforeDrawing
        copiedLabel.isHidden = isHidden
        copiedLabel.contentMode = contentMode
        copiedLabel.clipsToBounds = clipsToBounds
        copiedLabel.layer.masksToBounds = layer.masksToBounds
        copiedLabel.layer.cornerRadius = layer.cornerRadius
        copiedLabel.layer.borderWidth = layer.borderWidth
        copiedLabel.layer.borderColor = layer.borderColor?.copy()
        copiedLabel.layer.shadowPath = layer.shadowPath?.copy()
        copiedLabel.layer.shadowOffset = layer.shadowOffset
        copiedLabel.layer.shadowOpacity = layer.shadowOpacity
        copiedLabel.layer.shadowRadius = layer.shadowRadius
        
        if let attributedText {
            copiedLabel.attributedText = NSAttributedString(attributedString: attributedText)
        }
        
        return copiedLabel
    }
    
    func estimatedHeight(maxWidth: CGFloat) -> CGFloat {
        guard let text else { return .zero }
        
        let copiedLabel = deepCopy
        copiedLabel.sizeToFit()
        
        let autolayoutHeight = copiedLabel.systemLayoutSizeFitting(
            CGSize(width: maxWidth, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).height
        
        guard let font else { return autolayoutHeight }
        
        let stringBasedHeight = (text as NSString).boundingRect(
            with: .init(width: maxWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        ).height
        
        return max(autolayoutHeight, stringBasedHeight)
    }
    
    func estimatedWidth(maxWidth: CGFloat) -> CGFloat {
        guard let text else { return .zero }
        
        let copiedLabel = deepCopy
        copiedLabel.sizeToFit()
        let height = deepCopy.estimatedHeight(maxWidth: maxWidth)
        
        let autolayoutWidth = copiedLabel.systemLayoutSizeFitting(
            CGSize(width: maxWidth, height: height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        ).width
        
        guard let font else { return autolayoutWidth }
        
        let stringBasedWidth = (text as NSString).boundingRect(
            with: .init(width: maxWidth, height: height),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        ).width
        
        return max(autolayoutWidth, stringBasedWidth)
    }
}


