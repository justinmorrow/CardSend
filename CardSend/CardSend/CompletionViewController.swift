//
//  CompletionViewController.swift
//  CardSend
//
//  Created by Justin Morrow on 2/28/16.
//  Copyright © 2016 Miloma. All rights reserved.
//

import UIKit

class CompletionViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let circleIndicatorView = CircleIndicatorView()
        view.addSubview(circleIndicatorView)
        
        // Define constraints
        NSLayoutConstraint.activateConstraints([
            circleIndicatorView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            circleIndicatorView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
            circleIndicatorView.widthAnchor.constraintEqualToConstant(100.0),
            circleIndicatorView.heightAnchor.constraintEqualToAnchor(circleIndicatorView.widthAnchor)
        ])
    }
}

