//
//  ParentCoordinator.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import Foundation

/// The `ParentCoordinator` protocol is an extension of `Coordinator`
/// and is designed to handle child coordinators. This is useful for breaking down navigation
/// into smaller, manageable flows (e.g., authentication flow, main app flow).
protocol ParentCoordinator: Coordinator {
    /// A list of child coordinators managed by the parent.
    var childCoordinators: [Coordinator] { get set }
    
    /**
     Adds a child coordinator to the `childCoordinators` list.
     - Parameters:
        - child: The coordinator to be added.
     */
    func addChild(_ child: Coordinator?)
    
    /**
     Notifies the parent that a child coordinator has finished its work and should be removed.
     - Parameters:
        - child: The coordinator to be removed from the `childCoordinators` list.
     */
    func childDidFinish(_ child: Coordinator?)
}

extension ParentCoordinator {
    // MARK: - Default Implementation for ParentCoordinator Functions
    func addChild(_ child: Coordinator?) {
        if let _child = child {
            childCoordinators.append(_child)
        }
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
