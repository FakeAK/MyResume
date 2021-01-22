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
    
    private let viewModel: ResumeViewModel = ResumeViewModel()
    
    private let transition = BubbleTransition()
    private let interactiveTransition = BubbleInteractiveTransition()
    private var dataSource: CardListCollectionViewDataSource<CardListCollectionViewCell, Resume>?
    
    private lazy var cardList: CardListCollectionViewController = {
        let cardList = CardListCollectionViewController()
        cardList.delegate = self
        return cardList
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLayout()
        makeStyle()
        viewModel.fetchResume()
        bindViewModelToController()
    }
    
    private func makeLayout() {
        cardList.attach(to: self, in: view)
        cardList.view.snp.makeConstraints { (cardList) in
            cardList.top.equalTo(0.15 * self.view.frame.size.height)
            cardList.leading.equalToSuperview()
            cardList.trailing.equalToSuperview()
            cardList.bottom.equalToSuperview().inset(0.2 * self.view.frame.size.height)
        }
    }
    
    private func makeStyle() {
        view.backgroundColor = .white
    }
    
    private func bindViewModelToController() {
        viewModel.didFetchResume = { resume in
            self.dataSource = CardListCollectionViewDataSource(resume: resume)
            self.cardList.collectionView.dataSource = self.dataSource
            self.cardList.collectionView.reloadData()
        }
        
        viewModel.didGetError = { error in
            print(error)
            if let error = error as? APIError {
                self.cardList.removeFromParentViewController()
                // TODO: attach ErrorViewController
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
