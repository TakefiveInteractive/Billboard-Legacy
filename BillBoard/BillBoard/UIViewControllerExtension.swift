//
//  ViewControllerExtension.swift
//  PaperPlane
//
//  Created by Kedan Li on 15/7/26.
//  Copyright (c) 2015年 Takefive Interactive. All rights reserved.
//

import UIKit

extension UIViewController{
    
    func getChildViewControllerOfClass(theClass: AnyClass)->AnyObject?{
        for controller in childViewControllers{
            if controller.isMemberOfClass(theClass){
                return controller
            }
        }
        return nil
    }
    
    func displayLoginViewController(){
        var loginViewController = self.storyboard!.instantiateViewControllerWithIdentifier("loginView") as! LoginViewController
        loginViewController.didMoveToParentViewController(self)
        self.presentViewController(loginViewController, animated: true, completion: nil)
        loginViewController.view!.alpha = 0
        self.view.addSubview(loginViewController.view)
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            loginViewController.view!.alpha = 1
        })
    }

}
