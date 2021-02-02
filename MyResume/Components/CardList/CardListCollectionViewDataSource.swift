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
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CardListCollectionViewController.personalCellIdentifier,
                for: indexPath
            ) as! PersonalCardCollectionViewCell
            
            cell.fullNameLabel.text = "\(resume.personalInformations.firstName) \(resume.personalInformations.lastName)"
            cell.jobTitleLabel.text = resume.personalInformations.jobTitle
            cell.imageView.sd_setImage(with: URL(string: resume.personalInformations.photo)!)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: CardListCollectionViewController.experienceCellIdentifier,
                for: indexPath
            ) as! ExperienceCardListCollectionViewCell
            
            let experience = resume.experiences[indexPath.row]
            cell.companyNameLabel.text = experience.company.name
            cell.jobTitleLabel.text = experience.jobTitle
            cell.dateLabel.text = "\(Date.getShortDateAsString(from: experience.from)) - \(Date.getShortDateAsString(from: experience.to))"
            
            if let logo = experience.company.logo, let url = URL(string: logo) {
                cell.companyLogoImageView.sd_setImage(with: url) { (image, _, _, _) in
                    cell.companyLogoImageView.image = image?.withRenderingMode(.alwaysTemplate)
                }
            }
            
            return cell
        default:
            return collectionView.dequeueReusableCell(
                withReuseIdentifier: CardListCollectionViewController.cellIdentifier,
                for: indexPath
            ) as! CardListCollectionViewCell
        }
    }
}
