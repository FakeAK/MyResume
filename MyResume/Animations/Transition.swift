//
//  Transition.swift
//  MyResume
//
//  Created by Arthur Kleiber on 22/01/2021.
//

import Foundation
import UIKit

class Transition: NSObject, UIViewControllerAnimatedTransitioning {
    
    static let `default` = Transition()
    
    enum Mode {
        case present
        case dismiss
    }
    
    enum `Type` {
        case bubble
    }
    
    let duration: TimeInterval = 0.7
    var mode = Mode.present
    var type = Type.bubble
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch mode {
        case .present:
            runPresentTransition(context: transitionContext)
        case .dismiss:
            runDismissTransition(context: transitionContext)
        }
    }
    
    func runPresentTransition(context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard let toView = context.view(forKey: .to) else {
            assertionFailure("Recipient view for transition is nil")
            
            // For production: cancel transition smoothly
            context.cancelInteractiveTransition()
            context.completeTransition(false)
            return
        }
        
        containerView.addSubview(toView)
        var mask: CAShapeLayer
        var animation: CABasicAnimation
        let animationId = "path"
        
        switch type {
        case .bubble:
            (mask, animation) = makeBubble(for: toView)
        }
        
        animation.keyPath = animationId
        toView.layer.mask = mask
        runAnimation(animation: animation, mask: mask, transitionContext: context)
    }
    
    func runDismissTransition(context: UIViewControllerContextTransitioning) {
        // TODO
    }
    
    func makeBubble(for view: UIView) -> (mask: CAShapeLayer, animation: CABasicAnimation) {
        let circleDiameter = UIScreen.main.bounds.height + 100
        let mask = makeMask(
            position: CGPoint(x: view.bounds.width / 2, y: view.bounds.height / 2),
            path: UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 0, height: 0), cornerRadius: 0)
        )
        let animation = makeAnimation(
            fromValue: mask.path!,
            toValue: UIBezierPath(
                roundedRect: CGRect(
                    x: -circleDiameter / 2,
                    y: -circleDiameter / 2,
                    width: circleDiameter,
                    height: circleDiameter
                ),
                cornerRadius: circleDiameter / 2
            ).cgPath
        )
        
        return (mask, animation)
    }
    
    func runAnimation(animation: CABasicAnimation, mask: CAShapeLayer, transitionContext: UIViewControllerContextTransitioning) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(duration)
        CATransaction.setCompletionBlock {
            mask.removeFromSuperlayer()
            transitionContext.completeTransition(true)
        }
        mask.add(animation, forKey: animation.keyPath)
        CATransaction.commit()
    }
    
    func makeMask(position: CGPoint, path: UIBezierPath) -> CAShapeLayer {
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.position = position
        return mask
    }
    
    func makeAnimation(fromValue: CGPath, toValue: CGPath) -> CABasicAnimation {
        let animation = CABasicAnimation()
        animation.duration = duration
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.fromValue = fromValue
        animation.toValue = toValue
        
        return animation
    }
}
