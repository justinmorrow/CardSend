//
//  CheckmarkView.swift
//  CardSend
//
//  Created by Justin Morrow on 2/27/16.
//  Copyright © 2016 Miloma. All rights reserved.
//

import UIKit

class CheckmarkView: UIView {
    
    let checkmarkLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    func animate() {
        let checkAnimation = CABasicAnimation(keyPath: "strokeEnd")
        checkAnimation.beginTime = CACurrentMediaTime() + 1.0
        checkAnimation.duration = 0.4
        checkAnimation.fromValue = 0.0
        checkAnimation.toValue = 1.0
        checkAnimation.fillMode = kCAFillModeForwards
        checkAnimation.removedOnCompletion = false
        checkAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        checkmarkLayer.addAnimation(checkAnimation, forKey: "check")
    }
}