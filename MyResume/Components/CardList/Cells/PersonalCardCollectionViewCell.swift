//
//  PersonalCardCollectionViewCell.swift
//  MyResume
//
//  Created by Arthur Kleiber on 21/01/2021.
//

import Foundation
import UIKit

final class PersonalCardCollectionViewCell: CardListCollectionViewCell {
    
    // MARK: - Views
    let imageView = UIImageView()
    let filterView = UIView()
    let labelContainer = UIView()
    let fullNameLabel = UILabel()
    let jobTitleLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        containerView.addSubview(imageView)
        containerView.addSubview(filterView)
        containerView.addSubview(labelContainer)
        labelContainer.addSubview(fullNameLabel)
        labelContainer.addSubview(jobTitleLabel)
        makeCellStyle()
        makeCellLayout()
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
        
        labelContainer.snp.makeConstraints { (container) in
            container.trailing.leading.equalToSuperview()
            container.bottom.equalToSuperview().inset(bounds.size.height / 8)
        }
        
        fullNameLabel.snp.makeConstraints { (label) in
            label.top.equalToSuperview()
            label.leading.trailing.equalToSuperview().inset(20)
        }
        
        jobTitleLabel.snp.makeConstraints { (label) in
            label.top.equalTo(fullNameLabel.snp.bottom).offset(20)
            label.leading.trailing.equalToSuperview().inset(20)
            label.bottom.equalToSuperview()
        }
    }
    
    private func makeCellStyle() {
        imageView.contentMode = .scaleAspectFill
        fullNameLabel.textColor = .white
        fullNameLabel.textAlignment = .center
        fullNameLabel.alpha = 0
        fullNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        jobTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        jobTitleLabel.textColor = .white
        jobTitleLabel.textAlignment = .center
        jobTitleLabel.alpha = 0
        filterView.backgroundColor = Colors.blueOverlay
    }
    
    private func animate() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.7) {
                self.fullNameLabel.alpha = 1
                self.jobTitleLabel.alpha = 1
                self.fullNameLabel.snp.updateConstraints { (label) in
                    label.top.equalToSuperview().inset(10)
                }
                self.jobTitleLabel.snp.updateConstraints { (label) in
                    label.top.equalTo(self.fullNameLabel.snp.bottom).offset(0)
                }
                self.labelContainer.layoutIfNeeded()
            }
        }
    }
}
