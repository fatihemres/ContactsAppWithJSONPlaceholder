//
//  LoadingIndicatorView.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import SwiftUI
import UIKit

/// A UIView wrapper for embedding a SwiftUI-based loading indicator into UIKit.
/// Provides a reusable UIKit component for showing a loading animation.
class LoadingIndicatorView: UIView {

    /// By using `UIHostingController`, we can embed a SwiftUI component within a UIKit-based application.
    /// This approach allows us to leverage SwiftUI's modern UI features while maintaining compatibility with existing UIKit architecture.
    private let hostingController: UIHostingController<LoadingIndicator> // Embeds the SwiftUI view.
    
    override init(frame: CGRect) {
        hostingController = UIHostingController(rootView: LoadingIndicator())
        super.init(frame: frame)
        
        // Add the SwiftUI view to the UIKit hierarchy.
        addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
