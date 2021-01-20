//
//  CardListCollectionViewControllerDelegate.swift
//  MyResume
//
//  Created by Arthur Kleiber on 20/01/2021.
//

import Foundation

public protocol CardListCollectionViewControllerDelegate: class {
    func didSelectCard(at indexPath: IndexPath)
}
