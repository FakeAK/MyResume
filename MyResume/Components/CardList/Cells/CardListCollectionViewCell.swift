//
//  CardListCollectionViewCell.swift
//  MyResume
//
//  Created by Arthur Kleiber on 20/01/2021.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit

public class CardListCollectionViewCell: UICollectionViewCell {
    
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(containerView)
        makeLayout()
        makeStyle()
        runAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeStyle() {
        alpha = 0
        backgroundColor = .white
        layer.cornerRadius = 10
        layer.shadowColor = Colors.shadowCard.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.3
        layer.shouldRasterize = false // if true then font in cell will have poor quality
        layer.masksToBounds = false
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 10
    }
    
    private func makeLayout() {
        containerView.snp.makeConstraints { (containerView) in
            containerView.edges.equalToSuperview()
        }
    }
    
    internal func runAnimation() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 1
        }
    }
}
