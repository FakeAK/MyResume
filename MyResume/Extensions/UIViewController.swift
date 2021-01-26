//
//  UIViewController.swift
//  MyResume
//
//  Created by Arthur Kleiber on 18/01/2021.
//

import Foundation
import UIKit
import SwiftUI

extension UIViewController {
    func addSwiftUIContent<Content: View>(content: Content, in view: UIView) {
        let childViewController = UIHostingController(rootView: content)
        
        addChild(childViewController)
        childViewController.view.frame = view.frame
        childViewController.view.backgroundColor = .yellow
        view.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
    }
    
    func removeFromParentViewController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func attach(to viewController: UIViewController, in view: UIView) {
        viewController.addChild(self)
        self.view.frame = view.bounds
        view.addSubview(self.view)
        self.didMove(toParent: viewController)
    }
}

extension UIViewController: UIViewControllerTransitioningDelegate {
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        Transition.default.mode = .present
        return Transition.default
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        Transition.default.mode = .dismiss
        return Transition.default
    }
}
