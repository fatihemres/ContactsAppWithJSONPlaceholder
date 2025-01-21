//
//  UIView + Extensions.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit

/// An extension for `UIView` to simplify the process of adding multiple subviews.
extension UIView {
    /// Adds multiple subviews to the view in a single call.
    /// - Parameter views: A variadic list of `UIView` objects to be added as subviews.
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
