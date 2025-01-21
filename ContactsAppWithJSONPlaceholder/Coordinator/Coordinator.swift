//
//  Coordinator.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import UIKit

/// The `Coordinator` protocol defines a blueprint for navigation logic in the app.
/// It provides a clean and modular way to manage navigation between view controllers,
/// reducing coupling and improving scalability.
protocol Coordinator: AnyObject {
    /// The navigation controller associated with the coordinator.
    /// This navigation controller is used to manage and display the view controllers on the screen.
    var navigationController: UINavigationController { get set }
    
    /**
     Activates the coordinator, initializing and displaying its associated view controller(s).
     - Parameters:
        - animated: Set to true to animate the transition. Use false for immediate navigation or when setting up the navigation stack before presenting it.
    */
    func start(animated: Bool)
    
    /**
     Pops the current view controller from the navigation stack.
     - Parameters:
        - animated: Set to true for a smooth transition animation.
        - useCustomAnimation: Determines whether a custom animation will be used.
        - transitionType: The type of custom transition (e.g., `.fade`, `.push`).
    */
    func popViewController(animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType)
}

extension Coordinator {
    /**
     Pops the top view controller from the navigation stack.
     - Parameters:
        - animated: Set to true for a smooth transition animation.
        - useCustomAnimation: Set to true to use a custom transition, such as a top-to-bottom animation.
        - transitionType: Specifies the type of animation when using custom transitions.
     */
    func popViewController(animated: Bool, useCustomAnimation: Bool = false, transitionType: CATransitionType = .push) {
        if useCustomAnimation {
            navigationController.customPopViewController(transitionType: transitionType)
        } else {
            navigationController.popViewController(animated: animated)
        }
    }
    
    /**
     Pops view controllers until the specified one is at the top of the navigation stack.
     - Parameters:
        - ofClass: The class of the view controller to navigate to.
        - animated: Set to true for a smooth transition animation.
     */
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        navigationController.popToViewController(ofClass: ofClass, animated: animated)
    }
    
    /**
     Pops view controllers until the specified view controller is at the top of the stack.
     - Parameters:
        - viewController: The target view controller to navigate to.
        - animated: Set to true for a smooth transition animation.
        - useCustomAnimation: Set to true to use a custom transition animation.
        - transitionType: Specifies the type of custom transition (e.g., `.fade`, `.push`).
     */
    func popViewController(to viewController: UIViewController, animated: Bool, useCustomAnimation: Bool, transitionType: CATransitionType = .push) {
        if useCustomAnimation {
            navigationController.customPopToViewController(viewController: viewController, transitionType: transitionType)
        } else {
            navigationController.popToViewController(viewController, animated: animated)
        }
    }
}
