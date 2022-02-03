//
//  UIViewExtension.swift
//  ETC
//
//  Created by Giordano Menegazzi on 18/03/2019.
//  Copyright © 2019 Autodidact BV. All rights reserved.
//

import UIKit

// MARK: - UIView Anchoring Extension
/// this extension handles all the custom UIView anchoring constraint functions "AutoLayout!!"
extension UIView {
    // MARK: - Combined Anchoring Functions
    /// this function lets you set all the anchors / paddings and sizes of an UIViewObject all in one function
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top { topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true }
        if let leading = leading {  leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true }
        if let bottom = bottom { bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true }
        if let trailing = trailing { trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    /// this function anchors the top with padding, width and center x-axis
    func anchorTopWidthAndCenterXaxis(anchorTo: NSLayoutYAxisAnchor, padding: CGFloat, width: CGFloat) {
        anchorCenterToXAxisSuperview()
        anchorTop(anchorTo: anchorTo, padding: padding)
        anchorWidth(width: width)
    }
    
    /// this function anchors the bottom with padding, width and center x-axis
    func anchorBottomWidthAndCenterXaxis(anchorTo: NSLayoutYAxisAnchor, padding: CGFloat, width: CGFloat) {
        anchorCenterToXAxisSuperview()
        anchorBottom(anchorTo: anchorTo, padding: padding)
        anchorWidth(width: width)
    }
    
    /// this function anchors the top, leading and trailing anchors with custom top and side paddings
    func anchorTopLeadingTrailing(inView: UIView, anchorTopTo: NSLayoutYAxisAnchor, topPadding: CGFloat, sidePadding: CGFloat) {
        anchor(top: anchorTopTo, leading: inView.leadingAnchor, bottom: nil, trailing: inView.trailingAnchor, padding: .init(top: topPadding, left: sidePadding, bottom: 0, right: sidePadding))
    }
    
    /// this function anchors the bottom, leading and trailing with sidePadding and title spacings
    func anchorBottomLeadingTrailing(inView: UIView, anchorBottomTo: NSLayoutYAxisAnchor, bottomPadding: CGFloat, sidePadding: CGFloat) {
        anchor(top: nil, leading: inView.leadingAnchor, bottom: anchorBottomTo, trailing: inView.trailingAnchor, padding: .init(top: 0, left: sidePadding, bottom: bottomPadding, right: sidePadding))
    }
    
    
    
    
    
    
    // MARK: - Flexible Bottom Anchor Function
    /// this function anchors the bottom anchor with an greater than or eaqual to padding
    func anchorBottomWithGreaterThanOrEqualToPadding(anchorTo: NSLayoutYAxisAnchor, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        let bottom = bottomAnchor.constraint(equalTo: anchorTo, constant: -padding)
        bottom.priority = UILayoutPriority(rawValue: 250)
        bottom.isActive = true
    }
    
    
    
    
    
    
    // MARK: - ButtonStackView Anchoring Functions
    /// this function puts the 2 buttons in a stackview and anchors it
    func anchorButtonsWithStackViewTop(inView: UIView, anchorTopTo: NSLayoutYAxisAnchor, padding: CGFloat, leftButton: NormalButton, rightButton: NormalButton) {
        let btnSpacing: CGFloat = 20
        let ButtonStackView = customUIStackView(arrangedSubviews: [leftButton, rightButton], distribution: .fillEqually, axis: .horizontal, spacing: btnSpacing)
        addSubview(ButtonStackView)
        ButtonStackView.anchor(top: anchorTopTo, leading: inView.leadingAnchor, bottom: nil, trailing: inView.trailingAnchor, padding: .init(top: padding, left: flexibleSizes.controlsSidePadding, bottom: 0, right: flexibleSizes.controlsSidePadding))
    }
    
    /// this function puts the 2 buttons in a stackview and anchors it with the top and an greater than or equal bottom anchor
    func anchorButtonsWithStackViewTopAndBottomGreaterThanOrEqual(inView: UIView, anchorTopTo: NSLayoutYAxisAnchor, anchorBottomTo: NSLayoutYAxisAnchor , topPadding: CGFloat, bottomPadding: CGFloat, leftButton: NormalButton, rightButton: NormalButton) {
        let btnSpacing: CGFloat = 20
        let ButtonStackView = customUIStackView(arrangedSubviews: [leftButton, rightButton], distribution: .fillEqually, axis: .horizontal, spacing: btnSpacing)
        addSubview(ButtonStackView)
        ButtonStackView.anchor(top: anchorTopTo, leading: inView.leadingAnchor, bottom: nil, trailing: inView.trailingAnchor, padding: .init(top: topPadding, left: flexibleSizes.controlsSidePadding, bottom: 0, right: flexibleSizes.controlsSidePadding))
        ButtonStackView.anchorBottomWithGreaterThanOrEqualToPadding(anchorTo: anchorBottomTo, padding: bottomPadding)
    }
    
    /// this function puts the 2 buttons in a stackview and anchors it in a Popup
    func anchorButtonsWithStackViewInPopupTop(inView: UIView, anchorTopTo: NSLayoutYAxisAnchor, padding: CGFloat, leftButton: NormalButton, rightButton: NormalButton) {
        let btnSpacing: CGFloat = 20
        let ButtonStackView = customUIStackView(arrangedSubviews: [leftButton, rightButton], distribution: .fillEqually, axis: .horizontal, spacing: btnSpacing)
        addSubview(ButtonStackView)
        ButtonStackView.anchor(top: anchorTopTo, leading: inView.leadingAnchor, bottom: nil, trailing: inView.trailingAnchor, padding: .init(top: padding, left: flexibleSizes.controlsSidePaddingPopup, bottom: 0, right: flexibleSizes.controlsSidePaddingPopup))
    }
    
    /// this function puts the 2 buttons in a stackview and anchors it with the top and an greater than or equal bottom anchor in a Popup
    func anchorButtonsWithStackViewInPopupTopAndBottomGreaterThanOrEqual(inView: UIView, anchorTopTo: NSLayoutYAxisAnchor, anchorBottomTo: NSLayoutYAxisAnchor , topPadding: CGFloat, bottomPadding: CGFloat, leftButton: NormalButton, rightButton: NormalButton) {
        let btnSpacing: CGFloat = 20
        let ButtonStackView = customUIStackView(arrangedSubviews: [leftButton, rightButton], distribution: .fillEqually, axis: .horizontal, spacing: btnSpacing)
        addSubview(ButtonStackView)
        ButtonStackView.anchor(top: anchorTopTo, leading: inView.leadingAnchor, bottom: nil, trailing: inView.trailingAnchor, padding: .init(top: topPadding, left: flexibleSizes.controlsSidePaddingPopup, bottom: 0, right: flexibleSizes.controlsSidePaddingPopup))
        ButtonStackView.anchorBottomWithGreaterThanOrEqualToPadding(anchorTo: anchorBottomTo, padding: bottomPadding)
    }
    
    
    
    
    
    
    // MARK: - Individual Anchoring Functions
    /// this function anchors the top anchor with a custom padding
    func anchorTop(anchorTo: NSLayoutYAxisAnchor, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: anchorTo, constant: padding).isActive = true
    }
    
    /// this function anchors the leading anchor with a custom padding
    func anchorLeading(anchorTo: NSLayoutXAxisAnchor, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: anchorTo, constant: padding).isActive = true
    }
    
    /// this function anchors the bottom anchor with a custom padding
    func anchorBottom(anchorTo: NSLayoutYAxisAnchor, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: anchorTo, constant: -padding).isActive = true
    }
    
    /// this function anchors the trailing anchor with a custom padding
    func anchorTrailing(anchorTo: NSLayoutXAxisAnchor, padding: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        trailingAnchor.constraint(equalTo: anchorTo, constant: -padding).isActive = true
    }
    
    
    
    
    
    
    // MARK: - Centering Anchor Functions
    /// this function anchors the center to the superviews center X anchor
    func anchorCenterToXAxisSuperview() {
        guard let superViewCenterXanchor = superview?.centerXAnchor else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superViewCenterXanchor).isActive = true
    }
    
    /// this function anchors the center to the superviews center X anchor with a custom padding
    func anchorCenterToXAxisSuperviewWithPadding(padding: CGFloat) {
        guard let superViewCenterXanchor = superview?.centerXAnchor else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superViewCenterXanchor, constant: padding).isActive = true
    }
    
    /// this function anchors the center to the superviews center Y anchor
    func anchorCenterToYAxisSuperview() {
        guard let superViewCenterYanchor = superview?.centerYAnchor else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superViewCenterYanchor).isActive = true
    }
    
    /// this function anchors the center to the superviews center Y anchor with a custom padding
    func anchorCenterToYAxisSuperviewWithPadding(padding: CGFloat) {
        guard let superViewCenterYanchor = superview?.centerYAnchor else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superViewCenterYanchor, constant: padding).isActive = true
    }
    
    
    /// this function anchors the views center to another views Y center
    func anchorCenterYaxisToYAxisOtherView(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    /// this function anchors the views center to another views X center
    func anchorCenterXaxisToXAxisOtherView(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    /// this function anchors the center to the superviews center X and Y anchors
    func anchorCenterInSuperview() {
        anchorCenterToXAxisSuperview()
        anchorCenterToYAxisSuperview()
    }
    
    
    
    
    
    
    // MARK: - Sizing Anchor Functions
    /// this function sets the width anchor
    func anchorWidth(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    /// this function sets the flexible height anchor
    func anchorWidthGreaterThanorEqualTo(width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(greaterThanOrEqualToConstant: width).isActive = true
    }
    
    /// this function sets the height anchor
    func anchorHeight(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    /// this function sets the flexible height anchor
    func anchorHeightGreaterThanorEqualTo(height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(greaterThanOrEqualToConstant: height).isActive = true
    }
    
    /// this function sets the width and height anchors
    func anchorSize(width: CGFloat, height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    
    
    
    
    
    // MARK: - Fill superView Anchoring Functions
    /// this function anchors to the superview its anchors
    func fillSuperview() {
        guard let superview = superview else { return }
        anchor(top: superview.topAnchor, leading: superview.leadingAnchor, bottom: superview.bottomAnchor, trailing: superview.trailingAnchor)
    }
    
    /// this function anchors to the superview its safe area anchors
    func fillToSuperviewSafeArea() {
        guard let superview = superview else { return }
        anchor(top: superview.safeAreaLayoutGuide.topAnchor, leading: superview.safeAreaLayoutGuide.leadingAnchor, bottom: superview.safeAreaLayoutGuide.bottomAnchor, trailing: superview.safeAreaLayoutGuide.trailingAnchor)
    }
    
    /// this function anchors to the superview its anchors with padding
    func fillSuperviewWithCustomPadding(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) {
        guard let superview = superview else { return }
        anchor(top: superview.topAnchor, leading: superview.leadingAnchor, bottom: superview.bottomAnchor, trailing: superview.trailingAnchor, padding: .init(top: top, left: left, bottom: bottom, right: right))
    }
    
    
    
    
    
    
    // MARK: - Add multiple subviews at once Function
    /// this function adds multiple subviews after each other
    func addSubviews(views: [UIView]) {
        for view in views {
            addSubview(view)
        }
    }
}
