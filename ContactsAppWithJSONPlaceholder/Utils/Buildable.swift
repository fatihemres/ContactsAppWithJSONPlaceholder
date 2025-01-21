//
//  Buildable.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit

/// `Buildable` is a protocol designed for creating and configuring `UIViewController` instances.
/// It provides a standardized way to encapsulate the logic required to construct view controllers,
/// ensuring consistency and modularity across the app.
public protocol Buildable {
    /// Constructs and returns a fully configured `UIViewController` instance.
    /// This method encapsulates the creation process, allowing for cleaner and more maintainable code.
    /// - Returns: A `UIViewController` instance ready for use.
    func build() -> UIViewController
}
