//
//  ContactViewController.swift
//  CardSend
//
//  Created by Justin Morrow on 2/27/16.
//  Copyright © 2016 Miloma. All rights reserved.
//

import UIKit
import ContactsUI

class ContactViewController: UIViewController, CNContactPickerDelegate {
    
    let contactPoster = ContactPoster()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        // Create and add doneButton to view
        let doneButton = UIButton(type: .System)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.addTarget(self, action: "presentTransactionNavigationController", forControlEvents: .TouchUpInside)
        view.addSubview(doneButton)
        
        // Create and add chooseContactButton to view
        let chooseContactButton = UIButton(type: .System)
        chooseContactButton.translatesAutoresizingMaskIntoConstraints = false
        chooseContactButton.setTitle("Choose Contact", forState: .Normal)
        chooseContactButton.addTarget(self, action: "presentContactPickerViewController", forControlEvents: .TouchUpInside)
        view.addSubview(chooseContactButton)
        
        // Define constraints
        NSLayoutConstraint.activateConstraints([
            doneButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            doneButton.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
            chooseContactButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor),
            chooseContactButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -15.0)
        ])
    }
    
    func presentTransactionNavigationController() {
        let transactionViewController = TransactionViewController()
        let transactionNavigationController = UINavigationController(rootViewController: transactionViewController)
        transactionNavigationController.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        transactionNavigationController.navigationBar.translucent = true
        presentViewController(transactionNavigationController, animated: true, completion: nil)
    }
    
    func presentContactPickerViewController() {
        let contactPickerViewController = CNContactPickerViewController()
        contactPickerViewController.delegate = self
        presentViewController(contactPickerViewController, animated: true, completion: nil)
    }
    
    func contactPickerDidCancel(picker: CNContactPickerViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        contactPoster.postData(contact) { (error) -> Void in
            print(error)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
}