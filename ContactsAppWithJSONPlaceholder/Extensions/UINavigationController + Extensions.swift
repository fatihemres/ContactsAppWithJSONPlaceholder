//
//  UINavigationController + Ext.swift
//  ContactsAppWithJSONPlaceholder
//
//  Created by Fatih Emre on 20.01.2025.
//

import Foundation
import UIKit

private let _durationTime: CFTimeInterval = 0.25

public extension UINavigationController {
    
    /// Enum representing custom transition directions.
    enum VCTransition {
        case fromTop
        case fromBottom
    }

    /**
     Pops the current view controller to the previous one with a custom transition animation.
     - Parameters:
       - direction: The direction of the transition animation. Defaults to `.fromTop`.
       - transitionType: The type of transition (e.g., `.push` or `.fade`). Defaults to `.push`.
     */
    func customPopViewController(direction: VCTransition = .fromTop, transitionType: CATransitionType = .push) {
        self.addTransition(transitionDirection: direction, transitionType: transitionType)
        self.popViewController(animated: false)
    }

    /**
     Pops to a specific view controller on the navigation stack by its class.
     - Parameters:
       - ofClass: The class of the view controller to pop to.
       - animated: Whether the transition should be animated. Defaults to `true`.
     */
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
        if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
            popToViewController(vc, animated: animated)
        }
    }
    
    /**
     Pops all view controllers to the root view controller with a custom transition animation.
     - Parameters:
       - direction: The direction of the transition animation. Defaults to `.fromTop`.
       - transitionType: The type of transition (e.g., `.push` or `.fade`). Defaults to `.push`.
     */
    func customPopToRootViewController(direction: VCTransition = .fromTop, transitionType: CATransitionType = .push) {
        self.addTransition(transitionDirection: direction, transitionType: transitionType)
        self.popToRootViewController(animated: false)
    }

    /**
     Pops to a specific view controller on the navigation stack with a custom transition animation.
     - Parameters:
       - viewController: The view controller to pop to.
       - direction: The direction of the transition animation. Defaults to `.fromTop`.
       - transitionType: The type of transition (e.g., `.push` or `.fade`). Defaults to `.push`.
     */
    func customPopToViewController(viewController vc: UIViewController, direction: VCTransition = .fromTop, transitionType: CATransitionType = .push) {
        self.addTransition(transitionDirection: direction, transitionType: transitionType)
        self.popToViewController(vc, animated: false)
    }

    /**
     Pushes a new view controller onto the navigation stack with a custom transition animation.
     - Parameters:
       - vc: The view controller to push.
       - direction: The direction of the transition animation. Defaults to `.fromBottom`.
       - transitionType: The type of transition (e.g., `.push` or `.fade`). Defaults to `.push`.
     */
    func customPushViewController(viewController vc: UIViewController, direction: VCTransition = .fromBottom, transitionType: CATransitionType = .push) {
        self.addTransition(transitionDirection: direction, transitionType: transitionType)
        self.pushViewController(vc, animated: false)
    }

    /**
     Adds a custom transition animation to the navigation controller.
     - Parameters:
       - direction: The direction of the transition animation.
       - transitionType: The type of transition (e.g., `.push` or `.fade`). Defaults to `.push`.
       - duration: The duration of the transition animation. Defaults to `_durationTime`.
     */
    private func addTransition(transitionDirection direction: VCTransition, transitionType: CATransitionType = .push, duration: CFTimeInterval = _durationTime) {
        let transition = CATransition()
        transition.duration = duration
        transition.type = transitionType
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)

        switch direction {
        case .fromBottom:
            transition.subtype = .fromBottom
        case .fromTop:
            transition.subtype = .fromTop
        }

        self.view.layer.add(transition, forKey: kCATransition)
    }
}
