//
//  UIView+Ext.swift
//  IrsyadBasicUtility
//
//  Created by Muh Irsyad Ashari on 01/03/24.
//

import UIKit

extension UIView {
    func fillSuperView(to superView: UIView, distance: Int = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: CGFloat(distance)).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: CGFloat(distance)).isActive = true
        topAnchor.constraint(equalTo: superView.topAnchor, constant: CGFloat(distance)).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: CGFloat(distance)).isActive = true
    }
    
    @discardableResult
    func parent(_ view: UIView) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        return self
    }
    
    func clearSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
