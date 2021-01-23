//
//  HostingViewController.swift
//  MyResume
//
//  Created by Arthur Kleiber on 22/01/2021.
//

import Foundation
import UIKit
import SwiftUI

/**
 * Custom Hosting View Controller for hosting Swift UI View
 * It is used as a bridge between a UIViewController and an UIHostingController that host a SwiftUI View
 * Why doing this instead of just using UIHostingViewController to bridge the ViewController to the SwiftUI View ?
 * Customs transitions between a ViewController and a UIHostingController with modalPresentationStyle
 * set to custom on the UIHostingController make the transition stuck.
 * By doing this it works well but it adds a layer in the stack.
 */
final class HostingViewController<Content: DismissableView>: UIViewController {
    
    var bridgeViewController: UIHostingController<Content>
    
    init(bridgeViewController: UIHostingController<Content>) {
        self.bridgeViewController = bridgeViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bridgeViewController.attach(to: self, in: view)
        bridgeViewController.rootView.dismiss = dismissHostViewController
    }
    
    func dismissHostViewController() {
        dismiss(animated: true)
    }
}

protocol DismissableView: View {
    var dismiss: (() -> Void)? { get set }
}
