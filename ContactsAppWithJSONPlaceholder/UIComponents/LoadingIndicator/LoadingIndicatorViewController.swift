//
//  ActivityIndicatorViewController.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit

/// A view controller for presenting the loading indicator within a UIKit interface.
/// Acts as a container for the `LoadingIndicatorView` component.
class LoadingIndicatorViewController: UIViewController {
    
    private var loadingIndicator: LoadingIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.mainBackground.withAlphaComponent(0.75) // Semi-transparent background.
        setupLoadingIndicator()
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator = LoadingIndicatorView()
        if let activityIndicator = loadingIndicator {
            activityIndicator.center = view.center
            view.addSubview(activityIndicator)
        }
    }
}
