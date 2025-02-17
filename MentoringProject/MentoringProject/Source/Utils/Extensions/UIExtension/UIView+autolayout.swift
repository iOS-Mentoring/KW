//
//  UIView+autolayout.swift
//  YDUI
//
//  Created by 류연수 on 12/14/24.
//

import UIKit

public extension UIView {
    
    enum Layout {
        case top(CGFloat = 0)
        case leading(CGFloat = 0)
        case bottom(CGFloat = 0)
        case trailing(CGFloat = 0)
        
        case topSafeArea(CGFloat = 0)
        case leadingSafeArea(CGFloat = 0)
        case bottomSafeArea(CGFloat = 0)
        case trailingSafeArea(CGFloat = 0)
        
        case topEqual(to: UIView, constant: CGFloat = 0)
        case leadingEqual(to: UIView, constant: CGFloat = 0)
        case bottomEqual(to: UIView, constant: CGFloat = 0)
        case trailingEqual(to: UIView, constant: CGFloat = 0)
        
        case topNext(to: UIView, constant: CGFloat = 0)
        case leadingNext(to: UIView, constant: CGFloat = 0)
        
        case width(CGFloat = 0)
        case height(CGFloat = 0)
        
        case widthEqual(to: UIView, constant: CGFloat = 0)
        case heightEqual(to: UIView, constant: CGFloat = 0)
        
        case centerX(CGFloat = 0)
        case centerY(CGFloat = 0)
        case center(CGFloat = 0)

        case fillX(CGFloat = 0)
        case fillY(CGFloat = 0)
        case fill(CGFloat = 0)

        case fillSafeAreaX(CGFloat = 0)
        case fillSafeAreaY(CGFloat = 0)
        case fillSafeArea(CGFloat = 0)
        
        case topGreaterThan(CGFloat = 0)
        case leadingGreaterThan(CGFloat = 0)
        case bottomGreaterThan(CGFloat = 0)
        case trailingGreaterThan(CGFloat = 0)
        case topSafeAreaGreaterThan(CGFloat = 0)
        case leadingSafeAreaGreaterThan(CGFloat = 0)
        case bottomSafeAreaGreaterThan(CGFloat = 0)
        case trailingSafeAreaGreaterThan(CGFloat = 0)
        case topEqualGreaterThan(to: UIView, constant: CGFloat = 0)
        case leadingEqualGreaterThan(to: UIView, constant: CGFloat = 0)
        case bottomEqualGreaterThan(to: UIView, constant: CGFloat = 0)
        case trailingEqualGreaterThan(to: UIView, constant: CGFloat = 0)
        case topNextGreaterThan(to: UIView, constant: CGFloat = 0)
        case leadingNextGreaterThan(to: UIView, constant: CGFloat = 0)
        case widthGreaterThan(CGFloat = 0)
        case heightGreaterThan(CGFloat = 0)
        case widthEqualGreaterThan(to: UIView, constant: CGFloat = 0)
        case heightEqualGreaterThan(to: UIView, constant: CGFloat = 0)
        case centerXGreaterThan(CGFloat = 0)
        case centerYGreaterThan(CGFloat = 0)
        case centerGreaterThan(CGFloat = 0)
        case fillXGreaterThan(CGFloat = 0)
        case fillYGreaterThan(CGFloat = 0)
        case fillGreaterThan(CGFloat = 0)
        case fillSafeAreaXGreaterThan(CGFloat = 0)
        case fillSafeAreaYGreaterThan(CGFloat = 0)
        case fillSafeAreaGreaterThan(CGFloat = 0)
        
        case topLessThan(CGFloat = 0)
        case leadingLessThan(CGFloat = 0)
        case bottomLessThan(CGFloat = 0)
        case trailingLessThan(CGFloat = 0)
        case topSafeAreaLessThan(CGFloat = 0)
        case leadingSafeAreaLessThan(CGFloat = 0)
        case bottomSafeAreaLessThan(CGFloat = 0)
        case trailingSafeAreaLessThan(CGFloat = 0)
        case topEqualLessThan(to: UIView, constant: CGFloat = 0)
        case leadingEqualLessThan(to: UIView, constant: CGFloat = 0)
        case bottomEqualLessThan(to: UIView, constant: CGFloat = 0)
        case trailingEqualLessThan(to: UIView, constant: CGFloat = 0)
        case topNextLessThan(to: UIView, constant: CGFloat = 0)
        case leadingNextLessThan(to: UIView, constant: CGFloat = 0)
        case widthLessThan(CGFloat = 0)
        case heightLessThan(CGFloat = 0)
        case widthEqualLessThan(to: UIView, constant: CGFloat = 0)
        case heightEqualLessThan(to: UIView, constant: CGFloat = 0)
        case centerXLessThan(CGFloat = 0)
        case centerYLessThan(CGFloat = 0)
        case centerLessThan(CGFloat = 0)
        case fillXLessThan(CGFloat = 0)
        case fillYLessThan(CGFloat = 0)
        case fillLessThan(CGFloat = 0)
        case fillSafeAreaXLessThan(CGFloat = 0)
        case fillSafeAreaYLessThan(CGFloat = 0)
        case fillSafeAreaLessThan(CGFloat = 0)
    }
    
    enum SizeLayout {
        case width(CGFloat = 0)
        case height(CGFloat = 0)
        
        case widthEqual(to: UIView, constant: CGFloat = 0)
        case heightEqual(to: UIView, constant: CGFloat = 0)
    }
    
    enum BaseLayout {
        case top, leading, bottom, trailing, centerX, centerY, width, height
    }
}

public extension UIView {
    private struct AssociatedKeys {
        static var storedConstraints = "storedConstraints"
    }
    
    private var storedConstraints: [BaseLayout: NSLayoutConstraint] {
        get {
            objc_getAssociatedObject(self, &AssociatedKeys.storedConstraints) as? [BaseLayout: NSLayoutConstraint] ?? [:]
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.storedConstraints, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addSubview(_ view: UIView, autoLayout: [UIView.Layout] = []) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        var newConstraints: [BaseLayout: NSLayoutConstraint] = [:]
        
        let layouts = autoLayout.map({ layout in
            switch layout {
            case .top(let constant):
                let top = view.topAnchor.constraint(equalTo: self.topAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leading(let constant):
                let leading = view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
            case .bottom(let constant): 
                let bottom = view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [bottom]
            case .trailing(let constant):
                let trailing = view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [trailing]
                
            case .topSafeArea(let constant): 
                let top = view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leadingSafeArea(let constant):
                let leading = view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
            case .bottomSafeArea(let constant):
                let bottom = view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [bottom]
            case .trailingSafeArea(let constant):
                let trailing = view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [trailing]
                
            case .topEqual(let to, let constant):
                let top = view.topAnchor.constraint(equalTo: to.topAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leadingEqual(let to, let constant):
                let leading = view.leadingAnchor.constraint(equalTo: to.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
            case .bottomEqual(let to, let constant):
                let bottom = view.bottomAnchor.constraint(equalTo: to.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [bottom]
            case .trailingEqual(let to, let constant):
                let trailing = view.trailingAnchor.constraint(equalTo: to.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [trailing]
                
            case .topNext(let to, let constant):
                let top = view.topAnchor.constraint(equalTo: to.bottomAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leadingNext(let to, let constant):
                let leading = view.leadingAnchor.constraint(equalTo: to.trailingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
                
            case .width(let constant):
                let width = view.widthAnchor.constraint(equalToConstant: constant)
                newConstraints[.width] = width
                return [width]
            case .height(let constant):
                let height = view.heightAnchor.constraint(equalToConstant: constant)
                newConstraints[.height] = height
                return [height]
                
            case .widthEqual(let to, let constant):
                let width = view.widthAnchor.constraint(equalTo: to.widthAnchor, constant: constant)
                newConstraints[.width] = width
                return [width]
            case .heightEqual(let to, let constant):
                let height = view.heightAnchor.constraint(equalTo: to.heightAnchor, constant: constant)
                newConstraints[.height] = height
                return [height]
                
            case .centerX(let constant):
                let centerX = view.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: constant)
                newConstraints[.centerX] = centerX
                return [centerX]
            case .centerY(let constant):
                let centerY = view.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: constant)
                newConstraints[.centerY] = centerY
                return [centerY]
            case .center(let constant):
                let centerX = view.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: constant)
                newConstraints[.centerX] = centerX
                let centerY = view.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: constant)
                newConstraints[.centerY] = centerY
                return [centerX, centerY]

            case .fillX(let constant):
                let leading = view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let trailing = view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [leading, trailing]
            case .fillY(let constant):
                let top = view.topAnchor.constraint(equalTo: self.topAnchor, constant: constant)
                newConstraints[.top] = top
                let bottom = view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [top, bottom]
            case .fill(let constant):
                let top = view.topAnchor.constraint(equalTo: self.topAnchor, constant: constant)
                newConstraints[.top] = top
                let leading = view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let bottom = view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                let trailing = view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [top, leading, bottom, trailing]
                
            case .fillSafeAreaX(let constant):
                let leading = view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let trailing = view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [leading, trailing]
            case .fillSafeAreaY(let constant):
                let top = view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: constant)
                newConstraints[.top] = top
                let bottom = view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [top, bottom]
            case .fillSafeArea(let constant):
                let top = view.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: constant)
                newConstraints[.top] = top
                let leading = view.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let bottom = view.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                let trailing = view.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [top, leading, bottom, trailing]
                
            case .topGreaterThan(let constant):
                let top = view.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leadingGreaterThan(let constant):
                let leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
            case .bottomGreaterThan(let constant):
                let bottom = view.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [bottom]
            case .trailingGreaterThan(let constant):
                let trailing = view.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [trailing]
                
            case .topSafeAreaGreaterThan(let constant):
                let top = view.topAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.topAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leadingSafeAreaGreaterThan(let constant):
                let leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
            case .bottomSafeAreaGreaterThan(let constant):
                let bottom = view.bottomAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [bottom]
            case .trailingSafeAreaGreaterThan(let constant):
                let trailing = view.trailingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [trailing]
                
            case .topEqualGreaterThan(let to, let constant):
                let top = view.topAnchor.constraint(greaterThanOrEqualTo: to.topAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leadingEqualGreaterThan(let to, let constant):
                let leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: to.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
            case .bottomEqualGreaterThan(let to, let constant):
                let bottom = view.bottomAnchor.constraint(greaterThanOrEqualTo: to.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [bottom]
            case .trailingEqualGreaterThan(let to, let constant):
                let trailing = view.trailingAnchor.constraint(greaterThanOrEqualTo: to.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [trailing]
                
            case .topNextGreaterThan(let to, let constant):
                let top = view.topAnchor.constraint(greaterThanOrEqualTo: to.bottomAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leadingNextGreaterThan(let to, let constant):
                let leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: to.trailingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
                
            case .widthGreaterThan(let constant):
                let width = view.widthAnchor.constraint(greaterThanOrEqualToConstant: constant)
                newConstraints[.width] = width
                return [width]
            case .heightGreaterThan(let constant):
                let height = view.heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
                newConstraints[.height] = height
                return [height]
                
            case .widthEqualGreaterThan(let to, let constant):
                let width = view.widthAnchor.constraint(greaterThanOrEqualTo: to.widthAnchor, constant: constant)
                newConstraints[.width] = width
                return [width]
            case .heightEqualGreaterThan(let to, let constant):
                let height = view.heightAnchor.constraint(greaterThanOrEqualTo: to.heightAnchor, constant: constant)
                newConstraints[.height] = height
                return [height]
                
            case .centerXGreaterThan(let constant):
                let centerX = view.centerXAnchor.constraint(greaterThanOrEqualTo: self.centerXAnchor, constant: constant)
                newConstraints[.centerX] = centerX
                return [centerX]
            case .centerYGreaterThan(let constant):
                let centerY = view.centerYAnchor.constraint(greaterThanOrEqualTo: self.centerYAnchor, constant: constant)
                newConstraints[.centerY] = centerY
                return [centerY]
            case .centerGreaterThan(let constant):
                let centerX = view.centerXAnchor.constraint(greaterThanOrEqualTo: self.centerXAnchor, constant: constant)
                newConstraints[.centerX] = centerX
                let centerY = view.centerYAnchor.constraint(greaterThanOrEqualTo: self.centerYAnchor, constant: constant)
                newConstraints[.centerY] = centerY
                return [centerX, centerY]

            case .fillXGreaterThan(let constant):
                let leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let trailing = view.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [leading, trailing]
            case .fillYGreaterThan(let constant):
                let top = view.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: constant)
                newConstraints[.top] = top
                let bottom = view.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [top, bottom]
            case .fillGreaterThan(let constant):
                let top = view.topAnchor.constraint(greaterThanOrEqualTo: self.topAnchor, constant: constant)
                newConstraints[.top] = top
                let leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let bottom = view.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                let trailing = view.trailingAnchor.constraint(greaterThanOrEqualTo: self.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [top, leading, bottom, trailing]
                
            case .fillSafeAreaXGreaterThan(let constant):
                let leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let trailing = view.trailingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [leading, trailing]
            case .fillSafeAreaYGreaterThan(let constant):
                let top = view.topAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.topAnchor, constant: constant)
                newConstraints[.top] = top
                let bottom = view.bottomAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [top, bottom]
            case .fillSafeAreaGreaterThan(let constant):
                let top = view.topAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.topAnchor, constant: constant)
                newConstraints[.top] = top
                let leading = view.leadingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let bottom = view.bottomAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                let trailing = view.trailingAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [top, leading, bottom, trailing]
                
            case .topLessThan(let constant):
                let top = view.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leadingLessThan(let constant):
                let leading = view.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
            case .bottomLessThan(let constant):
                let bottom = view.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [bottom]
            case .trailingLessThan(let constant):
                let trailing = view.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [trailing]
                
            case .topSafeAreaLessThan(let constant):
                let top = view.topAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.topAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leadingSafeAreaLessThan(let constant):
                let leading = view.leadingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
            case .bottomSafeAreaLessThan(let constant):
                let bottom = view.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [bottom]
            case .trailingSafeAreaLessThan(let constant):
                let trailing = view.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [trailing]
                
            case .topEqualLessThan(let to, let constant):
                let top = view.topAnchor.constraint(lessThanOrEqualTo: to.topAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leadingEqualLessThan(let to, let constant):
                let leading = view.leadingAnchor.constraint(lessThanOrEqualTo: to.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
            case .bottomEqualLessThan(let to, let constant):
                let bottom = view.bottomAnchor.constraint(lessThanOrEqualTo: to.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [bottom]
            case .trailingEqualLessThan(let to, let constant):
                let trailing = view.trailingAnchor.constraint(lessThanOrEqualTo: to.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [trailing]
                
            case .topNextLessThan(let to, let constant):
                let top = view.topAnchor.constraint(lessThanOrEqualTo: to.bottomAnchor, constant: constant)
                newConstraints[.top] = top
                return [top]
            case .leadingNextLessThan(let to, let constant):
                let leading = view.leadingAnchor.constraint(lessThanOrEqualTo: to.trailingAnchor, constant: constant)
                newConstraints[.leading] = leading
                return [leading]
                
            case .widthLessThan(let constant):
                let width = view.widthAnchor.constraint(lessThanOrEqualToConstant: constant)
                newConstraints[.width] = width
                return [width]
            case .heightLessThan(let constant):
                let height = view.heightAnchor.constraint(lessThanOrEqualToConstant: constant)
                newConstraints[.height] = height
                return [height]
                
            case .widthEqualLessThan(let to, let constant):
                let width = view.widthAnchor.constraint(lessThanOrEqualTo: to.widthAnchor, constant: constant)
                newConstraints[.width] = width
                return [width]
            case .heightEqualLessThan(let to, let constant):
                let height = view.heightAnchor.constraint(lessThanOrEqualTo: to.heightAnchor, constant: constant)
                newConstraints[.height] = height
                return [height]
                
            case .centerXLessThan(let constant):
                let centerX = view.centerXAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor, constant: constant)
                newConstraints[.centerX] = centerX
                return [centerX]
            case .centerYLessThan(let constant):
                let centerY = view.centerYAnchor.constraint(lessThanOrEqualTo: self.centerYAnchor, constant: constant)
                newConstraints[.centerY] = centerY
                return [centerY]
            case .centerLessThan(let constant):
                let centerX = view.centerXAnchor.constraint(lessThanOrEqualTo: self.centerXAnchor, constant: constant)
                newConstraints[.centerX] = centerX
                let centerY = view.centerYAnchor.constraint(lessThanOrEqualTo: self.centerYAnchor, constant: constant)
                newConstraints[.centerY] = centerY
                return [centerX, centerY]

            case .fillXLessThan(let constant):
                let leading = view.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let trailing = view.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [leading, trailing]
            case .fillYLessThan(let constant):
                let top = view.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor, constant: constant)
                newConstraints[.top] = top
                let bottom = view.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [top, bottom]
            case .fillLessThan(let constant):
                let top = view.topAnchor.constraint(lessThanOrEqualTo: self.topAnchor, constant: constant)
                newConstraints[.top] = top
                let leading = view.leadingAnchor.constraint(lessThanOrEqualTo: self.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let bottom = view.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                let trailing = view.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [top, leading, bottom, trailing]
                
            case .fillSafeAreaXLessThan(let constant):
                let leading = view.leadingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let trailing = view.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [leading, trailing]
            case .fillSafeAreaYLessThan(let constant):
                let top = view.topAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.topAnchor, constant: constant)
                newConstraints[.top] = top
                let bottom = view.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                return [top, bottom]
            case .fillSafeAreaLessThan(let constant):
                let top = view.topAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.topAnchor, constant: constant)
                newConstraints[.top] = top
                let leading = view.leadingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.leadingAnchor, constant: constant)
                newConstraints[.leading] = leading
                let bottom = view.bottomAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
                newConstraints[.bottom] = bottom
                let trailing = view.trailingAnchor.constraint(lessThanOrEqualTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -constant)
                newConstraints[.trailing] = trailing
                return [top, leading, bottom, trailing]
            }
        }).flatMap { $0 }
        
        NSLayoutConstraint.activate(layouts)
        view.updateStoredConstraints(as: newConstraints)
    }
    
    func autoLayout(_ layout: [SizeLayout]) {
        translatesAutoresizingMaskIntoConstraints = false
        
        var newConstraints: [BaseLayout: NSLayoutConstraint] = [:]
        
        let layouts = layout.map({ layout in
            switch layout {
            case .width(let constant):
                let width = self.widthAnchor.constraint(equalToConstant: constant)
                newConstraints[.width] = width
                return [width]
            case .height(let constant):
                let height = self.heightAnchor.constraint(equalToConstant: constant)
                newConstraints[.height] = height
                return [height]
                
            case .widthEqual(let to, let constant):
                let width = self.widthAnchor.constraint(equalTo: to.widthAnchor, constant: constant)
                newConstraints[.width] = width
                return [width]
            case .heightEqual(let to, let constant):
                let height = self.heightAnchor.constraint(equalTo: to.heightAnchor, constant: constant)
                newConstraints[.height] = height
                return [height]
            }
        }).flatMap { $0 }
        
        NSLayoutConstraint.activate(layouts)
        updateStoredConstraints(as: newConstraints)
    }
    
    private func updateStoredConstraints(as layouts: [BaseLayout: NSLayoutConstraint]) {
        layouts.forEach { layout, constraint in
            storedConstraints[layout] = constraint
        }
    }
    
    func updateConstraint(of layout: BaseLayout, constant: CGFloat) {
        if let constraint = storedConstraints[layout] {
            constraint.constant = constant
        }
    }
    
    func constant(of layout: BaseLayout) -> CGFloat? {
        guard let constraint = storedConstraints[layout] else { return nil }
        
        return constraint.constant
    }
}
