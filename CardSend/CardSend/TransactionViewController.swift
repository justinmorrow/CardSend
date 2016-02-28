//
//  TransactionViewController.swift
//  CardSend
//
//  Created by Justin Morrow on 2/27/16.
//  Copyright © 2016 Miloma. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController {
    
    let circleIndicatorView = CircleIndicatorView()
    
    let numberTextField = UITextField()
    let sendButton = UIButton(type: .System)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        // Define and add cancelButton to view
        let cancelButton = UIButton(type: .System)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.addTarget(self, action: "dismissTransactionView", forControlEvents: .TouchUpInside)
        view.addSubview(cancelButton)
        
        // Define and add numberTextField to view
        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        numberTextField.backgroundColor = UIColor.whiteColor()
        numberTextField.keyboardType = UIKeyboardType.PhonePad
        numberTextField.textAlignment = NSTextAlignment.Center
        numberTextField.layer.borderWidth = 1.0
        numberTextField.layer.borderColor = UIColor.grayColor().CGColor
        view.addSubview(numberTextField)
        
        // Define and add sendButton to view
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitle("Send", forState: .Normal)
        sendButton.addTarget(self, action: "sendFormData", forControlEvents: .TouchUpInside)
        view.addSubview(sendButton)
        
        // Create and add circleIndicatorView to view
        circleIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        circleIndicatorView.alpha = 0.0
        self.view.addSubview(circleIndicatorView)
        
        // Define constraints
        NSLayoutConstraint.activateConstraints([
            cancelButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 15.0),
            cancelButton.topAnchor.constraintEqualToAnchor(self.topLayoutGuide.bottomAnchor),
            
            numberTextField.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 15),
            numberTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -15),
            numberTextField.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
            
            sendButton.topAnchor.constraintEqualToAnchor(numberTextField.bottomAnchor, constant: 15),
            sendButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            
            circleIndicatorView.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            circleIndicatorView.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
            circleIndicatorView.widthAnchor.constraintEqualToConstant(100.0),
            circleIndicatorView.heightAnchor.constraintEqualToAnchor(circleIndicatorView.widthAnchor),
            
            ])
    }
    
    func dismissTransactionView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sendFormData() {
        numberTextField.hidden = true
        sendButton.hidden = true
        
        let phoneNumber = numberTextField.text
        print(phoneNumber!)
        
        circleIndicatorView.alpha = 1.0
        circleIndicatorView.animateDrawAndSpin()
//        circleIndicatorView.animateFillAndCheck()

    }
}