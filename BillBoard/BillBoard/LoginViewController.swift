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

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    var loginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(isConnectedToNetwork())
        
        self.loginButton = FBSDKLoginButton()
        self.loginButton.center = self.view.center
        self.loginButton.delegate = self
        self.view.addSubview(self.loginButton)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
    }

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        
    }
    
    @IBAction func exit(){
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

