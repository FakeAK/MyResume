//
//  ExperienceCardListCollectionViewCell.swift
//  MyResume
//
//  Created by Arthur Kleiber on 22/01/2021.
//

import Foundation
import UIKit

final class ExperienceCardListCollectionViewCell: CardListCollectionViewCell {
    
    // MARK: - Views
    let imageView = UIImageView()
    let filterView = UIView()
    let companyLogoImageView = UIImageView()
    let infoContainer = UIView()
    let companyNameLabel = UILabel()
    let jobTitleLabel = UILabel()
    let dateLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        containerView.addSubview(imageView)
        containerView.addSubview(filterView)
        containerView.addSubview(infoContainer)
        infoContainer.addSubview(companyLogoImageView)
        infoContainer.addSubview(companyNameLabel)
        infoContainer.addSubview(jobTitleLabel)
        infoContainer.addSubview(dateLabel)
        
        makeCellLayout()
        makeCellStyle()
        animate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeCellLayout() {
        imageView.snp.makeConstraints { (imageView) in
            imageView.edges.equalToSuperview()
        }
        
        filterView.snp.makeConstraints { (view) in
            view.edges.equalToSuperview()
        }
        
        infoContainer.snp.makeConstraints { (container) in
            container.centerY.equalToSuperview()
            container.leading.trailing.equalToSuperview()
        }
        
        companyLogoImageView.snp.makeConstraints { (imageView) in
            imageView.top.equalToSuperview()
            imageView.centerX.equalToSuperview()
            imageView.width.equalTo(70)
            imageView.height.equalTo(70)
        }
        
        companyNameLabel.snp.makeConstraints { (label) in
            label.top.equalTo(companyLogoImageView.snp.bottom).offset(10)
            label.leading.trailing.equalToSuperview().inset(20)
        }
        
        jobTitleLabel.snp.makeConstraints { (label) in
            label.top.equalTo(companyNameLabel.snp.bottom).offset(20)
            label.leading.trailing.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints { (label) in
            label.top.equalTo(jobTitleLabel.snp.bottom).offset(20)
            label.leading.trailing.equalToSuperview().inset(20)
            label.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func makeCellStyle() {
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "office1")
        
        companyLogoImageView.alpha = 0
        companyLogoImageView.image = #imageLiteral(resourceName: "logo_jin_white")
        companyLogoImageView.contentMode = .scaleAspectFit
        
        companyNameLabel.textColor = .white
        companyNameLabel.textAlignment = .center
        companyNameLabel.alpha = 0
        companyNameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        
        jobTitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        jobTitleLabel.textColor = .white
        jobTitleLabel.textAlignment = .center
        jobTitleLabel.alpha = 0
        
        dateLabel.alpha = 0
        dateLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        dateLabel.textColor = .white
        dateLabel.textAlignment = .center
        
        filterView.backgroundColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.4)
    }
    
    private func animate() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.7) {
                self.companyLogoImageView.alpha = 1
                self.companyNameLabel.alpha = 1
                self.dateLabel.alpha = 1
                self.jobTitleLabel.alpha = 1
                self.companyNameLabel.snp.updateConstraints { (label) in
                    label.top.equalTo(self.companyLogoImageView.snp.bottom).offset(0)
                }
                self.jobTitleLabel.snp.makeConstraints { (label) in
                    label.top.equalTo(self.companyNameLabel.snp.bottom).offset(0)
                }
                self.infoContainer.layoutIfNeeded()
            }
        }
    }
}
