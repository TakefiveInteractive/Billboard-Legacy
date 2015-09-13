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
        var loginViewController: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier("LoginViewController")!
        addChildViewController(loginViewController as! UIViewController)
        loginViewController.didMoveToParentViewController(self)
        self.view.addSubview(loginViewController.view)
        loginViewController.view!.alpha = 0
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            loginViewController.view!.alpha = 1
        })
    }

}
