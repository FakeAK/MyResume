//
//  CardListTableViewController.swift
//  MyResume
//
//  Created by Arthur Kleiber on 20/01/2021.
//

import Foundation
import UIKit
import SnapKit

class CardListCollectionViewController: UICollectionViewController {
    
    static let cellIdentifier = "CardListCollectionViewCell"
    static let personalCellIdentifier = "personalCellIdentifier"
    
    weak var delegate: CardListCollectionViewControllerDelegate?
    var customLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    init() {
        customLayout.scrollDirection = .horizontal
        customLayout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        customLayout.scrollDirection = .horizontal
        customLayout.minimumLineSpacing = 20
        
        super.init(collectionViewLayout: customLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setCollectionViewItemSize()
    }
    
    private func setCollectionViewItemSize() {
        let width = UIScreen.main.bounds.width * 0.8
        let height = view.frame.height - 10 // -10 is for letting space to the cell shadow
        customLayout.itemSize = CGSize(width: width, height: height)
    }
    
    private func initCollectionView() {
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        registerCells()
    }
    
    private func registerCells() {
        collectionView.register(
            CardListCollectionViewCell.self,
            forCellWithReuseIdentifier: CardListCollectionViewController.cellIdentifier
        )
        collectionView.register(
            PersonalCardCollectionViewCell.self,
            forCellWithReuseIdentifier: CardListCollectionViewController.personalCellIdentifier
        )
    }
}



// MARK: - Delegate
extension CardListCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
//        delegate?.didSelectCard(at: indexPath)
    }
}
