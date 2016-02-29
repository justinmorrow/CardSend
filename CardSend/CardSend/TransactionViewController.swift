//
//  TransactionViewController.swift
//  CardSend
//
//  Created by Justin Morrow on 2/27/16.
//  Copyright © 2016 Miloma. All rights reserved.
//

import UIKit

class TransactionViewController: UIViewController, UITextFieldDelegate {
    
    let numberTextField = UITextField()
    let sendButton = UIButton(type: .System)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: "cancelView")
        
        // Define and add numberTextField to view
        numberTextField.translatesAutoresizingMaskIntoConstraints = false
        numberTextField.backgroundColor = UIColor.whiteColor()
        numberTextField.keyboardType = UIKeyboardType.PhonePad
        numberTextField.textAlignment = NSTextAlignment.Center
        numberTextField.font = UIFont.systemFontOfSize(36.0)
        numberTextField.delegate = self
        view.addSubview(numberTextField)
        numberTextField.becomeFirstResponder()
        
        // Define and add sendButton to view
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.setTitle("Send", forState: .Normal)
        sendButton.addTarget(self, action: "sendFormData", forControlEvents: .TouchUpInside)
        view.addSubview(sendButton)
        
        // Define constraints
        NSLayoutConstraint.activateConstraints([
            numberTextField.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 15),
            numberTextField.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -15),
            numberTextField.centerYAnchor.constraintEqualToAnchor(view.centerYAnchor),
            
            sendButton.topAnchor.constraintEqualToAnchor(numberTextField.bottomAnchor, constant: 15),
            sendButton.centerXAnchor.constraintEqualToAnchor(view.centerXAnchor)
        ])
    }
    
    func cancelView() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sendFormData() {
        let phoneNumber = numberTextField.text
        print(phoneNumber!)
        
        let completionViewController = CompletionViewController()
        completionViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(completionViewController, animated: true, completion: nil)
//        showViewController(completionViewController, sender: self)
    }
    
    // Delegate function to format numberTextField to Apple's "Contacts" format
    // From <http://stackoverflow.com/questions/1246439/uitextfield-for-phone-number>
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        
        let decimalString = components.joinWithSeparator("") as NSString
        let length = decimalString.length
        let hasLeadingOne = length > 0 && decimalString.characterAtIndex(0) == (1 as unichar)
        
        if length == 0 || (length > 10 && !hasLeadingOne) || length > 11 {
            let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
            
            return (newLength > 10) ? false : true
        }
        var index = 0 as Int
        let formattedString = NSMutableString()
        
        if hasLeadingOne {
            formattedString.appendString("1 ")
            index += 1
        }
        if (length - index) > 3 {
            let areaCode = decimalString.substringWithRange(NSMakeRange(index, 3))
            formattedString.appendFormat("(%@)", areaCode)
            index += 3
        }
        if length - index > 3 {
            let prefix = decimalString.substringWithRange(NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", prefix)
            index += 3
        }
        
        let remainder = decimalString.substringFromIndex(index)
        formattedString.appendString(remainder)
        textField.text = formattedString as String
        return false
    }
}