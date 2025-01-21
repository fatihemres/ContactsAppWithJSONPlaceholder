//
//  ChildCoordinator.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit

/// The `ChildCoordinator` protocol extends `Coordinator` to represent
/// coordinators that are managed by a `ParentCoordinator`.
protocol ChildCoordinator: Coordinator {
    /**
     Notifies the parent coordinator that the child has completed its task and should be removed.
     This function should call `childDidFinish(_:)` on the parent coordinator.
     */
    func coordinatorDidFinish()
    
    /// A reference to the view controller associated with the child coordinator.
    var viewControllerRef: UIViewController? { get set }
}
