//
//  ResumeViewController.swift
//  MyResume
//
//  Created by Arthur Kleiber on 18/01/2021.
//

import Foundation
import UIKit
import SwiftUI
import Combine
import SnapKit
import Lottie

class ResumeViewController: UIViewController {
    
    private let viewModel: ResumeViewModel = ResumeViewModel()
    private var dataSource: CardListCollectionViewDataSource<CardListCollectionViewCell, Resume>?
    
    private var cardList: CardListCollectionViewController?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeStyle()
        viewModel.fetchResume()
        bindViewModelToController()
    }
    
    private func makeStyle() {
        view.backgroundColor = .white
    }
    
    private func bindViewModelToController() {
        viewModel.didFetchResume = { resume in
            self.addCardListToView()
            self.reloadCardList(resume: resume)
            self.addSocialNetworksList(socialNetworks: resume.personalInformations.socialNetworks)
        }
        
        viewModel.didGetError = { error in
            let errorViewController = UIHostingController(rootView: FetchResumeErrorView(message: error.localizedDescription))
            self.view.addSubview(errorViewController.view)
            errorViewController.view.snp.makeConstraints { (view) in
                view.centerX.centerY.equalToSuperview()
                view.width.equalToSuperview()
                view.height.equalTo(200)
            }
        }
    }
    
    private func addCardListToView() {
        cardList = CardListCollectionViewController()
        cardList?.delegate = self
        cardList?.attach(to: self, in: view)
        cardList?.view.snp.makeConstraints { (cardList) in
            cardList.top.equalTo(0.15 * self.view.frame.size.height)
            cardList.leading.equalToSuperview()
            cardList.trailing.equalToSuperview()
            cardList.bottom.equalToSuperview().inset(0.2 * self.view.frame.size.height)
        }
    }
    
    private func reloadCardList(resume: Resume) {
        DispatchQueue.main.async {
            self.dataSource = CardListCollectionViewDataSource(resume: resume)
            self.cardList?.collectionView.dataSource = self.dataSource
            self.cardList?.collectionView.reloadData()
        }
    }
    
    private func addSocialNetworksList(socialNetworks: [SocialNetwork]) {
        let footer = UIView()
        view.addSubview(footer)
        footer.snp.makeConstraints { (footer) in
            footer.trailing.leading.equalToSuperview()
            footer.bottom.equalToSuperview().inset(view.safeAreaInsets.bottom)
            footer.top.equalTo(cardList!.view.snp.bottom)
        }
        
        let socialNetworksViewHostVC = UIHostingController(rootView: CallToSocialButtonsView(socialNetworks: socialNetworks))
        socialNetworksViewHostVC.attach(to: self, in: footer)
        socialNetworksViewHostVC.view.snp.makeConstraints { (socialButtonsView) in
            socialButtonsView.leading.trailing.equalToSuperview()
            socialButtonsView.height.equalTo(100)
            socialButtonsView.centerY.equalToSuperview()
        }
    }
}


extension ResumeViewController: CardListCollectionViewControllerDelegate {
    func didSelectCard(at indexPath: IndexPath) {
        guard let resume = viewModel.resume else { return }
        var cardDetailsVC: UIViewController
        
        switch indexPath.section {
        case 0:
            cardDetailsVC = HostingViewController(
                bridgeViewController: UIHostingController(
                    rootView: PersonalCardDetailsView(
                        personalInformations: resume.personalInformations
                    )
                )
            )
        case 1:
            cardDetailsVC = HostingViewController(
                bridgeViewController: UIHostingController(
                    rootView: ExperienceCardDetailsView(
                        experience: resume.experiences[indexPath.row]
                    )
                )
            )
        default:
            return
        }
        
        
        cardDetailsVC.transitioningDelegate = self
        cardDetailsVC.modalPresentationStyle = .custom
        
        present(cardDetailsVC, animated: true)
    }
}
