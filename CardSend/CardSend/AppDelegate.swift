//
//  AppDelegate.swift
//  CardSend
//
//  Created by Justin Morrow on 2/27/16.
//  Copyright © 2016 Miloma. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window.rootViewController = ContactViewController()
        self.window = window
        window.makeKeyAndVisible()
        
        let person = Person(firstName: "Tim", lastName: "Cook", phoneNumber: "+12484967669", email: "tcook@apple.com", image: UIImage(named: "Tim.jpg")!)
        
        let poster = PersonPoster()
        
        poster.postPerson(person) { error in
            print(error)
        }
        
        return true
    }
}

