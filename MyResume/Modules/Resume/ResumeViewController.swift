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
import SnapKit

class ResumeViewController: UIViewController {
    
    let viewModel: ResumeViewModel = ResumeViewModel()
    
    let transition = BubbleTransition()
    let interactiveTransition = BubbleInteractiveTransition()
    
    private lazy var cardList: CardListCollectionViewController = {
        let cardList = CardListCollectionViewController()
        cardList.delegate = self
        return cardList
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchResume()
        bindViewModelToController()
    }
    
    private func makeLayout() {
        view.addSubview(cardList.view)
        cardList.view.snp.makeConstraints { (view) in
            view.top.equalTo(150)
            view.leading.equalToSuperview()
            view.trailing.equalToSuperview()
            view.bottom.equalToSuperview().inset(150)
        }
    }
    
    private func bindViewModelToController() {
        viewModel.didFetchResume = { resume in
            print(resume.personalInformations.firstName)
        }
        
        viewModel.didGetError = { error in
            if let error = error as? APIError {
                print(error.statusCode)
            }
        }
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
        transition.duration = 0.4
        
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = view.center
        transition.bubbleColor = .clear
        
        return transition
    }
}

extension ResumeViewController: CardListCollectionViewControllerDelegate {
    func didSelectCard(at indexPath: IndexPath) {
        let cardDetailsVC = CardDetailsViewController()
        
        cardDetailsVC.transitioningDelegate = self
        cardDetailsVC.modalPresentationStyle = .custom
        cardDetailsVC.modalPresentationCapturesStatusBarAppearance = true
        cardDetailsVC.interactiveTransition = interactiveTransition
        interactiveTransition.attach(to: cardDetailsVC)
        
        present(cardDetailsVC, animated: true)
    }
}
