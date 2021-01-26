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
    
    let duration: TimeInterval = 0.3
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
            let circleDiameter = UIScreen.main.bounds.height + 100
            (mask, animation) = makeBubble(
                for: toView,
                position: CGPoint(x: toView.bounds.width / 2, y: toView.bounds.height / 2),
                fromPath: UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 0, height: 0), cornerRadius: 0),
                toPath: UIBezierPath(
                    roundedRect: CGRect(
                        x: -circleDiameter / 2,
                        y: -circleDiameter / 2,
                        width: circleDiameter,
                        height: circleDiameter
                    ),
                    cornerRadius: circleDiameter / 2
                )
            )
        }
        
        animation.keyPath = animationId
        toView.layer.mask = mask
        runAnimation(animation: animation, mask: mask, transitionContext: context)
    }
    
    func runDismissTransition(context: UIViewControllerContextTransitioning) {
        let containerView = context.containerView
        guard let fromView = context.view(forKey: .from) else {
            assertionFailure("Recipient view for transition is nil")
            
            // For production: cancel transition smoothly
            context.cancelInteractiveTransition()
            context.completeTransition(false)
            return
        }
        
        containerView.addSubview(fromView)
        var mask: CAShapeLayer
        var animation: CABasicAnimation
        let animationId = "path"
        
        switch type {
        case .bubble:
            let circleDiameter = UIScreen.main.bounds.height + 100
            (mask, animation) = makeBubble(
                for: fromView,
                position: CGPoint(x: (fromView.bounds.width - circleDiameter) / 2, y: (fromView.bounds.height - circleDiameter) / 2),
                fromPath: UIBezierPath(
                    roundedRect: CGRect(
                        x: 0,
                        y: 0,
                        width: circleDiameter,
                        height: circleDiameter
                    ),
                    cornerRadius: circleDiameter / 2
                ),
                toPath: UIBezierPath(
                    roundedRect: CGRect(
                        x: circleDiameter / 2,
                        y: circleDiameter / 2,
                        width: 0,
                        height: 0
                    ),
                    cornerRadius: 0
                )
            )
        }
        
        animation.keyPath = animationId
        fromView.layer.mask = mask
        runAnimation(animation: animation, mask: mask, transitionContext: context)
    }
    
    func makeBubble(for view: UIView, position: CGPoint, fromPath: UIBezierPath, toPath: UIBezierPath) -> (mask: CAShapeLayer, animation: CABasicAnimation) {
        let mask = makeMask(
            position: position,
            path: fromPath
        )
        let animation = makeAnimation(
            fromValue: mask.path!,
            toValue: toPath.cgPath
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
