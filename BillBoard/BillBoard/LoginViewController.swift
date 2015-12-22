//
//  ViewController.swift
//  BillBoard
//
//  Created by YanHan on 15/9/11.
//  Copyright (c) 2015年 Takefive Interactive. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loginButton = FBSDKLoginButton()
        self.loginButton.center = self.view.center
        self.loginButton.delegate = self
        self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        self.view.addSubview(self.loginButton)
        
        var content = FBSDKShareLinkContent()
        content.contentURL = NSURL(string:"https://www.takefiveinteractive.com")
        content.contentTitle = "hahahah"
        content.peopleIDs = ["739437159512298"]
        var button = FBSDKShareButton()
        button.center = CGPointMake(100,100)
        button.shareContent = content
        button.userInteractionEnabled = true
        self.view.addSubview(button)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print(result.description)
        UserInfo.facebookLogin(result.token.tokenString, completion: { (succ, error, result) -> () in
            if succ{
                //succ
                self.exit()
            }else{
                print(error)
            }
        })
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        exit()
    }
    
    func exit(){
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

