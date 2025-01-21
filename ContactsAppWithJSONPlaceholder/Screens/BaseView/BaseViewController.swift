//
//  BaseViewController.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit

/// `BaseViewController` serves as the foundational class for all view controllers in the application.
/// It defines common behaviors and functionalities that can be reused across the app's view controllers.
class BaseViewController: UIViewController {

    // MARK: - Properties
    /// Handles the presentation of a loading indicator to indicate ongoing operations.
    private var loadingIndicator: LoadingIndicatorViewController?

    // MARK: - Initializer
    /// Initializes the view controller without a nib file or bundle.
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - UI Setup
    /// Configures the default UI for the view controller.
    /// Sets the background color to match the app's main theme.
    private func configureUI() {
        view.backgroundColor = .mainBackground
    }

    // MARK: - Activity Indicator
    /// Displays a loading indicator on top of the current view controller.
    /// This is used for long-running tasks where user feedback is required.
    func showLoadingIndicator() {
        guard loadingIndicator == nil else { return }
        
        loadingIndicator = LoadingIndicatorViewController()
        loadingIndicator?.modalPresentationStyle = .overCurrentContext
        loadingIndicator?.modalTransitionStyle = .crossDissolve
        
        if let activityIndicator = loadingIndicator {
            DispatchQueue.main.async {
                if self.isViewLoaded && self.view.window != nil {
                    self.present(activityIndicator, animated: true)
                }
            }
        }
    }

    /// Hides the loading indicator if it is currently being displayed.
    /// - Parameter completion: An optional closure to execute after the indicator is dismissed.
    func hideLoadingIndicator(completion: (VoidCallback)? = nil) {
        if let loadingIndicator = loadingIndicator {
            if let coordinator = transitionCoordinator {
                coordinator.animate(alongsideTransition: nil) { [weak self] _ in
                    guard let self = self else { return }
                    self.loadingIndicator?.dismiss(animated: true, completion: {
                        self.loadingIndicator = nil
                        completion?()
                    })
                }
            } else {
                loadingIndicator.dismiss(animated: true) { [weak self] in
                    self?.loadingIndicator = nil
                    completion?()
                }
            }
        } else {
            completion?()
        }
    }

    // MARK: - Alert Management
    func showAlert(title: String, message: String, actionTitle: String = "OK", action: VoidCallback? = nil) {
        guard isViewLoaded, view.window != nil else {
            print("View is not loaded or not in the window hierarchy.")
            return
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default) { _ in
            action?()
            self.navigationController?.popViewController(animated: true)
        })
        
        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
