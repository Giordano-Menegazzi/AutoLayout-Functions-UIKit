//
//  UIViewExtension.swift
//  ETC
//
//  Created by Giordano Menegazzi on 18/03/2019.
//  Copyright © 2019 Autodidact BV. All rights reserved.
//

import UIKit

extension UIView {
    /// This function can set each anchor individually (or multiple at once) and add paddings and sizes as well for every UIView Object
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top { topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true }
        if let leading = leading { leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true }
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true }
        if let trailing = trailing { trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true }
        
        if size.width != 0 { widthAnchor.constraint(equalToConstant: size.width).isActive = true }
        if size.height != 0 { heightAnchor.constraint(equalToConstant: size.height).isActive = true }
    }
    
    /// this function anchors the top, leading and trailing anchors with custom top and side paddings
    func anchorTopLeadingTrailing(inView: UIView, anchorTopTo: NSLayoutYAxisAnchor, topPadding: CGFloat, sidePadding: CGFloat) {
        anchor(top: anchorTopTo, leading: inView.leadingAnchor, bottom: nil, trailing: inView.trailingAnchor, padding: .init(top: topPadding, left: sidePadding, bottom: 0, right: sidePadding))
    }
    
    /// this function anchors the bottom, leading and trailing with sidePadding and title spacings
    func anchorBottomLeadingTrailing(inView: UIView, anchorBottomTo: NSLayoutYAxisAnchor, bottomPadding: CGFloat, sidePadding: CGFloat) {
        anchor(top: nil, leading: inView.leadingAnchor, bottom: anchorBottomTo, trailing: inView.trailingAnchor, padding: .init(top: 0, left: sidePadding, bottom: bottomPadding, right: sidePadding))
    }
    
    
    
    // MARK: - Flexible bottom anchor function
    /// This function anchors the top anchor with an greater than or eaqual to constant
    func anchorTopWithGreaterThanOrEqualToConstant(anchorTo: NSLayoutYAxisAnchor, constant: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let top = topAnchor.constraint(equalTo: anchorTo, constant: constant ?? 0)
        top.priority = UILayoutPriority(rawValue: 250)
        top.isActive = true
    }
    
    /// This function anchors the bottom anchor with an greater than or eaqual to constant
    func anchorBottomWithGreaterThanOrEqualToConstant(anchorTo: NSLayoutYAxisAnchor, constant: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        let bottom = bottomAnchor.constraint(equalTo: anchorTo, constant: -(constant ?? 0))
        bottom.priority = UILayoutPriority(rawValue: 250)
        bottom.isActive = true
    }
    
    
    
    // MARK: - Center anchoring functions
    /// This function anchors the center to the superviews center X anchor with an optional custom padding
    func anchorCenterToXAxisSuperview(padding: CGFloat? = nil) {
        guard let superViewCenterXanchor = superview?.centerXAnchor else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superViewCenterXanchor, constant: padding ?? 0).isActive = true
    }
    
    /// This function anchors the center to the superviews center Y anchor with an optional custom padding
    func anchorCenterToYAxisSuperview(padding: CGFloat? = nil) {
        guard let superViewCenterYanchor = superview?.centerYAnchor else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superViewCenterYanchor, constant: padding ?? 0).isActive = true
    }
    
    /// This function anchors the views center to another views X center
    func anchorCenterXaxisToXAxisOf(view: UIView, padding: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: padding ?? 0).isActive = true
    }
    
    /// This function anchors the views center to another views Y center
    func anchorCenterYaxisToYAxisOf(view: UIView, padding: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: padding ?? 0).isActive = true
    }
    
    /// This function anchors the center to the superviews center X and Y anchors
    func anchorCenterInSuperview(xPadding: CGFloat? = nil, yPadding: CGFloat? = nil) {
        anchorCenterToXAxisSuperview(with: xPadding ?? 0)
        anchorCenterToYAxisSuperview(with: yPadding ?? 0)
    }
    
    
    
    // MARK: - Size anchoring functions
    /// This function sets the width anchor
    func anchorWidth(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// This function sets a flexible width anchor
    func anchorWidthGreaterThanorEqualTo(_ width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
    }
    
    /// This function sets the height anchor
    func anchorHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// This function sets a flexible height anchor
    func anchorHeightGreaterThanorEqualTo(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
    }
    
    /// This function sets the width and height anchors
    func anchorSize(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    
    
    // MARK: - Fill superView anchoring functions
    /// This function anchors the view to it's superview safe area
    func fillSuperviewToSafeArea(padding: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        anchor(top: superview.safeAreaLayoutGuide.topAnchor, leading: superview.safeAreaLayoutGuide.leadingAnchor, bottom: superview.safeAreaLayoutGuide.bottomAnchor, trailing: superview.safeAreaLayoutGuide.trailingAnchor, padding: padding)
    }
    
    /// This function anchors the view to it's superview
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        guard let superview = superview else { return }
        anchor(top: superview.topAnchor, leading: superview.leadingAnchor, bottom: superview.bottomAnchor, trailing: superview.trailingAnchor, padding: padding)
    }
    
    
    
    // MARK: - Add multiple subviews function
    /// This function adds multiple subviews after each other
    func addSubviews(_ views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
