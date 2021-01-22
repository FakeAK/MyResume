//
//  CardDetailsViewController.swift
//  MyResume
//
//  Created by Arthur Kleiber on 18/01/2021.
//

import Foundation
import UIKit
import BubbleTransition
import SDWebImage

class CardDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView?
    weak var interactiveTransition: BubbleInteractiveTransition?
    
    init() {
        super.init(nibName: "CardDetailsView", bundle: Bundle(for: CardDetailsViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView?.image = #imageLiteral(resourceName: "akleiber")
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition
    }
}
