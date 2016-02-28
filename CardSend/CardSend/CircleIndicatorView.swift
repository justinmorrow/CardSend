//
//  CircleIndicatorView.swift
//  CardSend
//
//  Created by Justin Morrow on 2/27/16.
//  Copyright © 2016 Miloma. All rights reserved.
//

import UIKit

class CircleIndicatorView: UIView {
    
    let indicatorLayer = CAShapeLayer()
    let checkmarkLayer = CAShapeLayer()
    var arcPath = UIBezierPath()
    var smallPath = UIBezierPath()
    
    let initLineWidth: CGFloat = 8.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.addSublayer(indicatorLayer)
        indicatorLayer.strokeColor = UIColor(red: 0.0, green: 0.90, blue: 0.40, alpha: 0.0).CGColor
        indicatorLayer.lineWidth = initLineWidth
        indicatorLayer.fillColor = nil
        indicatorLayer.strokeStart = 1.0
        indicatorLayer.strokeEnd = 1.0
        indicatorLayer.lineCap = kCALineCapRound
        
        self.layer.addSublayer(checkmarkLayer)
        checkmarkLayer.strokeColor = UIColor.redColor().CGColor
        checkmarkLayer.lineWidth = 10.0
        checkmarkLayer.fillColor = nil
        checkmarkLayer.strokeStart = 0.0
        checkmarkLayer.strokeEnd = 0.0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePaths()
    }
    
    func updatePaths() {
        arcPath = UIBezierPath(ovalInRect: bounds.insetBy(dx: initLineWidth / 2.0, dy: initLineWidth / 2.0))
        smallPath = UIBezierPath(ovalInRect: bounds.insetBy(dx: bounds.width / 4.0, dy: bounds.height / 4.0))
        indicatorLayer.path = arcPath.CGPath
        indicatorLayer.bounds = bounds
        indicatorLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        
        let viewMidX = self.bounds.midX
        let viewMidY = self.bounds.midY
        
        // Scaling factor
        let k = CGFloat(20.0)
        
        let pt1x = viewMidX - k
        let pt1y = viewMidX - k
        let pt2x = viewMidX
        let pt2y = viewMidY
        let pt3x = viewMidX + 2.25*k
        let pt3y = viewMidY - 2.25*k
        
        let checkMidXOffset = -(pt3x - pt2x)*1/3
        let checkMidYOffset = (pt2y - pt1y)
        
        let checkmarkPath = UIBezierPath()
        checkmarkPath.moveToPoint(CGPoint(x: pt1x + checkMidXOffset, y: pt1y + checkMidYOffset))
        checkmarkPath.addLineToPoint(CGPoint(x: pt2x + checkMidXOffset, y: pt2y + checkMidYOffset))
        checkmarkPath.addLineToPoint(CGPoint(x: pt3x + checkMidXOffset, y: pt3y + checkMidYOffset))
        
        checkmarkLayer.path = checkmarkPath.CGPath
    }
    
    func animateDrawAndSpin() {
        
//        let drawAnimation = CABasicAnimation(keyPath: "strokeStart")
//        drawAnimation.beginTime = CACurrentMediaTime()
//        drawAnimation.duration = 2.0
//        drawAnimation.toValue = 0.15
//        drawAnimation.fillMode = kCAFillModeForwards
//        drawAnimation.removedOnCompletion = false
//        drawAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
//        indicatorLayer.addAnimation(drawAnimation, forKey: "draw")
        
        let fadeInAnimation = CABasicAnimation(keyPath: "strokeColor")
        fadeInAnimation.beginTime = CACurrentMediaTime()
        fadeInAnimation.duration = 1.0
        fadeInAnimation.toValue = UIColor(red: 0.0, green: 0.90, blue: 0.40, alpha: 1.0).CGColor
        fadeInAnimation.fillMode = kCAFillModeForwards
        fadeInAnimation.removedOnCompletion = false
        fadeInAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        indicatorLayer.addAnimation(fadeInAnimation, forKey: "fadeIn")
        
        let spinAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        spinAnimation.beginTime = CACurrentMediaTime()
        spinAnimation.duration = 2.1
        spinAnimation.toValue = CGFloat(2.0*M_PI)
        spinAnimation.cumulative = true
        spinAnimation.repeatCount = Float.infinity
        indicatorLayer.addAnimation(spinAnimation, forKey: "spin")
        
    }
    
    func animateFillAndCheck() {
        
        let closeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        closeAnimation.duration = 0.4
        closeAnimation.fromValue = 0.9
        closeAnimation.toValue = 1.0
        closeAnimation.fillMode = kCAFillModeForwards
        closeAnimation.removedOnCompletion = false
        
        let fillAnimation = CABasicAnimation(keyPath: "lineWidth")
        fillAnimation.toValue = bounds.width / 2.0
        
        let shrinkAnimation = CABasicAnimation(keyPath: "path")
        shrinkAnimation.toValue = smallPath.CGPath
        
        let fillAnimationGroup = CAAnimationGroup()
        fillAnimationGroup.animations = [
            fillAnimation,
            shrinkAnimation
        ]
        fillAnimationGroup.beginTime = 0.4
        fillAnimationGroup.fillMode = kCAFillModeForwards
        fillAnimationGroup.removedOnCompletion = false
        fillAnimationGroup.duration = 0.6
        
        let closeAndFillGroup = CAAnimationGroup()
        closeAndFillGroup.animations = [closeAnimation, fillAnimationGroup]
        closeAndFillGroup.beginTime = CACurrentMediaTime() + 5.0
        closeAndFillGroup.duration = 1.0
        closeAndFillGroup.speed = 4.0
        closeAndFillGroup.fillMode = kCAFillModeForwards
        closeAndFillGroup.removedOnCompletion = false
        closeAndFillGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        indicatorLayer.addAnimation(closeAndFillGroup, forKey: "closeAndFill")
        
        let checkAnimation = CABasicAnimation(keyPath: "strokeEnd")
        checkAnimation.beginTime = CACurrentMediaTime() + 6.0
        checkAnimation.duration = 0.4
        checkAnimation.fromValue = 0.0
        checkAnimation.toValue = 1.0
        checkAnimation.fillMode = kCAFillModeForwards
        checkAnimation.removedOnCompletion = false
        checkAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        checkmarkLayer.addAnimation(checkAnimation, forKey: "check")
        
    }
}
