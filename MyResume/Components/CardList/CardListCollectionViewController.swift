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
    
    static let reusableCellIdentifier = "CardListCollectionViewCell"
    
    var customLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    init() {
        customLayout.scrollDirection = .horizontal
        customLayout.sectionInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        customLayout.scrollDirection = .horizontal
        customLayout.minimumLineSpacing = 20
        
        super.init(collectionViewLayout: customLayout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.register(
            CardListCollectionViewCell.self,
            forCellWithReuseIdentifier: CardListCollectionViewController.reusableCellIdentifier
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let width = UIScreen.main.bounds.width * 0.8
        let height = view.frame.height - 10 // -10 is for letting space to the cell shadow
        customLayout.itemSize = CGSize(width: width, height: height)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CardListCollectionViewController.reusableCellIdentifier,
            for: indexPath
        )
        
        return cell
    }
}
