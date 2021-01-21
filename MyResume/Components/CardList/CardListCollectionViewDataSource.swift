//
//  CardListCollectionViewDataSource.swift
//  MyResume
//
//  Created by Arthur Kleiber on 21/01/2021.
//

import Foundation
import UIKit

class CardListCollectionViewDataSource<cell: UICollectionViewCell, T>: NSObject, UICollectionViewDataSource {
    
    var resume: Resume
    
    init(resume: Resume) {
        self.resume = resume
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return resume.experiences.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = createCell(collectionView, for: indexPath)
        return cell
    }
    
    func createCell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: CardListCollectionViewController.personalCellIdentifier,
                for: indexPath
            ) as! PersonalCardCollectionViewCell
        default:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: CardListCollectionViewController.cellIdentifier,
                for: indexPath
            ) as! CardListCollectionViewCell
        }
    }
}
