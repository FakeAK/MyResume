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
}
