//
//  ResumeViewController.swift
//  MyResume
//
//  Created by Arthur Kleiber on 18/01/2021.
//

import Foundation
import UIKit
import Combine
import BubbleTransition

class ResumeViewController: UIViewController {
    
    let viewModel: ResumeViewModel = ResumeViewModel()
    
    let transition = BubbleTransition()
    let interactiveTransition = BubbleInteractiveTransition()
    
    
    init() {
        super.init(nibName: "ResumeView", bundle: Bundle(for: ResumeViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchResume()
        view.backgroundColor = .red
        addSwiftUIContent(content: CardView(), in: view)
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(goToDetailsView)))
    }
    
    @objc func goToDetailsView() {
        let cardDetailsVC = CardDetailsViewController()
        
        cardDetailsVC.transitioningDelegate = self
        cardDetailsVC.modalPresentationStyle = .custom
        cardDetailsVC.modalPresentationCapturesStatusBarAppearance = true
        cardDetailsVC.interactiveTransition = interactiveTransition
        interactiveTransition.attach(to: cardDetailsVC)
        
        present(cardDetailsVC, animated: true)
    }
}

extension ResumeViewController: UIViewControllerTransitioningDelegate {
    public func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = view.center
        transition.bubbleColor = .clear
        
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = view.center
        transition.bubbleColor = .clear
        
        return transition
    }
}
