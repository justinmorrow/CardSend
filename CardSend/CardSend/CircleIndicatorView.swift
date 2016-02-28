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
    var arcPath = UIBezierPath()
    var smallPath = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        indicatorLayer.bounds = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
        indicatorLayer.strokeColor = UIColor.blueColor().CGColor
        indicatorLayer.lineWidth = 1.0
        indicatorLayer.fillColor = nil
        indicatorLayer.strokeStart = 0.0
        indicatorLayer.strokeEnd = 0.9
        self.layer.addSublayer(indicatorLayer)

        let radius = CGFloat(30.0)
        arcPath = UIBezierPath(arcCenter: self.center, radius: radius, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: true)
        indicatorLayer.path = arcPath.CGPath
        smallPath = UIBezierPath(arcCenter: self.center, radius: radius/2, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: true)
        
        indicatorLayer.path = arcPath.CGPath
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePaths()
    }
    
    func updatePaths() {
        indicatorLayer.position = self.center
    }
    
    func animateSpin() {
        let spinAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        spinAnimation.beginTime = CACurrentMediaTime() + 1.0
        spinAnimation.duration = 2.0
        spinAnimation.toValue = CGFloat(2.0*M_PI)
        spinAnimation.cumulative = true
        spinAnimation.repeatCount = Float.infinity
        indicatorLayer.addAnimation(spinAnimation, forKey: "spin")
    }
    
    func animateFillAndCheck() {
        let closeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        closeAnimation.beginTime = CACurrentMediaTime() + 3.0
        closeAnimation.duration = 1.0
        closeAnimation.fromValue = 0.9
        closeAnimation.toValue = 1.0
        closeAnimation.fillMode = kCAFillModeForwards
        closeAnimation.removedOnCompletion = false
        indicatorLayer.addAnimation(closeAnimation, forKey: "close")
        
        let fillAnimation = CABasicAnimation(keyPath: "lineWidth")
        fillAnimation.beginTime = CACurrentMediaTime() + 3.0
        fillAnimation.duration = 1.0
        fillAnimation.toValue = 30.0
        fillAnimation.fillMode = kCAFillModeForwards
        fillAnimation.removedOnCompletion = false
        indicatorLayer.addAnimation(fillAnimation, forKey: "fill")
        
        let shrinkAnimation = CABasicAnimation(keyPath: "path")
        shrinkAnimation.beginTime = CACurrentMediaTime() + 3.0
        shrinkAnimation.duration = 1.0
        shrinkAnimation.toValue = smallPath.CGPath
        shrinkAnimation.fillMode = kCAFillModeForwards
        shrinkAnimation.removedOnCompletion = false
        indicatorLayer.addAnimation(shrinkAnimation, forKey: "shrink")
    }
}
