//
//  UIViewExtension.swift
//  ETC
//
//  Created by Giordano Menegazzi on 18/03/2019.
//  Copyright © 2019 Autodidact BV. All rights reserved.
//

import UIKit

public extension UIView {

    func anchorTo(_ layoutGuide: UILayoutGuide, margins: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margins.top).isActive = true
        bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor, constant: -margins.bottom).isActive = true
        leftAnchor.constraint(equalTo: layoutGuide.leftAnchor, constant: margins.left).isActive = true
        rightAnchor.constraint(equalTo: layoutGuide.rightAnchor, constant: -margins.right).isActive = true
    }
    
    /// This function can set each `anchor` individually (or multiple at once) and adds `paddings` as well for every `UIView` Object
    @discardableResult
    func anchor(
        top: NSLayoutYAxisAnchor? = nil,
        leading: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        trailing: NSLayoutXAxisAnchor? = nil,
        padding: UIEdgeInsets = .zero
    ) -> (top: NSLayoutConstraint?, leading: NSLayoutConstraint?, bottom: NSLayoutConstraint?, trailing: NSLayoutConstraint?) {
        translatesAutoresizingMaskIntoConstraints = false
        
        var topConstraint: NSLayoutConstraint?
        var leadingConstraint: NSLayoutConstraint?
        var bottomConstraint: NSLayoutConstraint?
        var trailingConstraint: NSLayoutConstraint?
        if let top {
            topConstraint = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        if let leading {
            leadingConstraint = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        if let bottom {
            bottomConstraint = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        if let trailing {
            trailingConstraint = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        NSLayoutConstraint.activate(
            [topConstraint, leadingConstraint, bottomConstraint, trailingConstraint]
                .compactMap { $0 }
        )
        return (top: topConstraint, leading: leadingConstraint, bottom: bottomConstraint, trailing: trailingConstraint)
    }

    /// The calling view has to have the same superview as the `sibling` given as a parameter here
    /// Positive margins will make the calling view bigger than its sibling, negative smaller
    func anchor(toSibling sibling: UIView, margins: UIEdgeInsets = .zero) {
        guard let superview, superview === sibling.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        sibling.topAnchor.constraint(equalTo: topAnchor, constant: margins.top).isActive = true
        sibling.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margins.bottom).isActive = true
        sibling.leftAnchor.constraint(equalTo: leftAnchor, constant: margins.left).isActive = true
        sibling.rightAnchor.constraint(equalTo: rightAnchor, constant: -margins.right).isActive = true
    }

    func anchorToSuperview(top: Bool = true, bottom: Bool = true, left: Bool = true, right: Bool = true) {
        guard let superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: [NSLayoutConstraint] = []
        
        if top { constraints.append(topAnchor.constraint(equalTo: superview.topAnchor)) }
        if bottom { constraints.append(bottomAnchor.constraint(equalTo: superview.bottomAnchor)) }
        if left { constraints.append(leftAnchor.constraint(equalTo: superview.leftAnchor)) }
        if right { constraints.append(rightAnchor.constraint(equalTo: superview.rightAnchor)) }
        constraints.forEach { $0.isActive = true }
    }
    
    @discardableResult
    func anchorToSuperview(margins: UIEdgeInsets = .zero) -> (top: NSLayoutConstraint, bottom: NSLayoutConstraint, left: NSLayoutConstraint, right: NSLayoutConstraint)? {
        guard let superview else { return nil }
        translatesAutoresizingMaskIntoConstraints = false
        let top = topAnchor.constraint(equalTo: superview.topAnchor, constant: margins.top)
        let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -margins.bottom)
        let left = leftAnchor.constraint(equalTo: superview.leftAnchor, constant: margins.left)
        let right = rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -margins.right)
        NSLayoutConstraint.activate([top, bottom, left, right])
        return (top: top, bottom: bottom, left: left, right: right)
    }

    @discardableResult
    func anchor<T>(anchorSelf: NSLayoutAnchor<T>, to otherAnchor: NSLayoutAnchor<T>, padding: CGFloat = 0) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint = anchorSelf.constraint(equalTo: otherAnchor, constant: padding)
        constraint.isActive = true
        return constraint
    }

    // MARK: - Constraint size 

    func constrain(width: CGFloat? = nil, height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    // MARK: - Center anchoring functions

    func anchorToSuperviewCenter(safeArea: Bool = false) {
        anchorToSuperviewCenterX(safeArea: safeArea)
        anchorToSuperviewCenterY(safeArea: safeArea)
    }
    
    /// This function anchors the center to the `superview's` center X anchor with an optional custom `padding`
    @discardableResult
    func anchorToSuperviewCenterX(anchorSelf: NSLayoutXAxisAnchor? = nil, safeArea: Bool = false, padding: CGFloat = 0) -> NSLayoutConstraint? {
        guard let superview else { return nil }
        let superViewCenterXAnchor = safeArea ? superview.safeAreaLayoutGuide.centerXAnchor : superview.centerXAnchor
        return anchorXAxis(anchorSelf: anchorSelf, to: superViewCenterXAnchor, padding: padding)
    }
    
    @discardableResult
    func anchorXAxis(anchorSelf: NSLayoutXAxisAnchor? = nil, to otherAnchor: NSLayoutXAxisAnchor, padding: CGFloat = 0) -> NSLayoutConstraint {
        anchor(anchorSelf: anchorSelf ?? centerXAnchor, to: otherAnchor, padding: padding)
    }
    
    /// This function anchors the center to the `superview's` center Y anchor with an optional custom `padding`
    @discardableResult
    func anchorToSuperviewCenterY(anchorSelf: NSLayoutYAxisAnchor? = nil, safeArea: Bool = false, padding: CGFloat = 0) -> NSLayoutConstraint? {
        guard let superview else { return nil }
        let superViewCenterYAnchor = safeArea ? superview.safeAreaLayoutGuide.centerYAnchor : superview.centerYAnchor
        return anchorYAxis(anchorSelf: anchorSelf, to: superViewCenterYAnchor, padding: padding)
    }
    
    @discardableResult
    func anchorYAxis(anchorSelf: NSLayoutYAxisAnchor? = nil, to otherAnchor: NSLayoutYAxisAnchor, padding: CGFloat = 0) -> NSLayoutConstraint {
        anchor(anchorSelf: anchorSelf ?? centerYAnchor, to: otherAnchor, padding: padding)
    }
    
    // MARK: - Fill superView anchoring functions
    
    /// This function anchors the `view` to it's `superview's` `safeArea`
    func fillSuperviewToSafeArea(padding: UIEdgeInsets = .zero) {
        guard let superview else { return }
        anchor(
            top: superview.safeAreaLayoutGuide.topAnchor,
            leading: superview.safeAreaLayoutGuide.leadingAnchor,
            bottom: superview.safeAreaLayoutGuide.bottomAnchor,
            trailing: superview.safeAreaLayoutGuide.trailingAnchor,
            padding: padding
        )
    }
    
    /// This function anchors the `view` to it's `superview`
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        guard let superview else { return }
        anchor(
            top: superview.topAnchor,
            leading: superview.leadingAnchor,
            bottom: superview.bottomAnchor,
            trailing: superview.trailingAnchor,
            padding: padding
        )
    }
}

// MARK: - Addsubviews

public extension UIView {
    /// This function adds multiple `subviews` after each other
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
