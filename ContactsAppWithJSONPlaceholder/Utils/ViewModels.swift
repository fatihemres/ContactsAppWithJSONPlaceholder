//
//  ViewModels.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

/// A `ViewModel` protocol that defines a common interface for all view models in the application.
/// This protocol helps standardize the interaction between view models and their associated view controllers,
/// ensuring consistency across different parts of the app.
public protocol ViewModel {
    /// The title for the associated `ViewController`.
    /// This provides a default mechanism for view models to define the title displayed in the navigation bar or UI.
    var title: String? { get }
    
    /// Called when the associated `ViewController`'s `viewDidLoad` method is triggered.
    /// This function allows the view model to handle any initialization or data fetching required when the view is loaded.
    func start()
}

public extension ViewModel {
    /// Default implementation for `title` that returns `nil`.
    /// This ensures that implementing this property is optional for conforming view models.
    var title: String? { nil }
    
    /// Default implementation for `start` that does nothing.
    /// Conforming view models can override this method as needed to provide custom behavior.
    func start() { }
}
