//
//  CompletionViewController.swift
//  CardSend
//
//  Created by Justin Morrow on 2/28/16.
//  Copyright © 2016 Miloma. All rights reserved.
//

import UIKit

class CompletionViewController: UIViewController {
    
    let circleIndicatorView = CircleIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelView")
        circleIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(circleIndicatorView)
        
        // Define constraints
        NSLayoutConstraint.activateConstraints([
            circleIndicatorView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            circleIndicatorView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
            circleIndicatorView.widthAnchor.constraintEqualToConstant(100.0),
            circleIndicatorView.heightAnchor.constraintEqualToAnchor(circleIndicatorView.widthAnchor)
        ])
        
        self.circleIndicatorView.animateDrawAndSpin()
        
        let time1 = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
        dispatch_after(time1, dispatch_get_main_queue()) {
            self.circleIndicatorView.animateFillAndCheck()
        }
        
        let time2 = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 3 * Int64(NSEC_PER_SEC))
        dispatch_after(time2, dispatch_get_main_queue()) {
            self.cancelView()
        }
    }
    
    func cancelView() {
        navigationController?.popViewControllerAnimated(true)
    }
}

