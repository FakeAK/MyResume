//
//  PersonalCardCollectionViewCell.swift
//  MyResume
//
//  Created by Arthur Kleiber on 21/01/2021.
//

import Foundation
import UIKit

class PersonalCardCollectionViewCell: CardListCollectionViewCell {
    
    // MARK: - Views
    let imageView = UIImageView()
    let labelContainer = UIView()
    let fullNameLabel = UILabel()
    let jobTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        containerView.addSubview(imageView)
        containerView.addSubview(labelContainer)
        labelContainer.addSubview(fullNameLabel)
        labelContainer.addSubview(jobTitleLabel)
        
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
        
        labelContainer.snp.makeConstraints { (container) in
            container.height.equalTo(150)
            container.trailing.leading.equalToSuperview()
            container.bottom.equalToSuperview()
        }
        
        fullNameLabel.snp.makeConstraints { (label) in
            label.top.equalToSuperview().inset(0)
            label.leading.trailing.equalToSuperview().inset(20)
        }
        
        jobTitleLabel.snp.makeConstraints { (label) in
            label.top.equalTo(fullNameLabel.snp.bottom).offset(20)
            label.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func makeCellStyle() {
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: URL(string: "https://storage.googleapis.com/jin-agency-websites-media/team/managers/pb_portrait.jpg")!)
        fullNameLabel.text = "Arthur Kleiber"
        fullNameLabel.textColor = .white
        fullNameLabel.textAlignment = .center
        fullNameLabel.alpha = 0
        fullNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        jobTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        jobTitleLabel.text = "Full Stack Engineer"
        jobTitleLabel.textColor = .white
        jobTitleLabel.textAlignment = .center
        jobTitleLabel.alpha = 0
    }
    
    private func animate() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.7) {
                self.fullNameLabel.alpha = 1
                self.jobTitleLabel.alpha = 1
                self.fullNameLabel.snp.updateConstraints { (label) in
                    label.top.equalToSuperview().inset(10)
                }
                self.jobTitleLabel.snp.makeConstraints { (label) in
                    label.top.equalTo(self.fullNameLabel.snp.bottom).offset(0)
                }
                self.labelContainer.layoutIfNeeded()
            }
        }
    }
}
