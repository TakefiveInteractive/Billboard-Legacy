//
//  LeftMenuViewController.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController {

    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var GetHelpButton: UIButton!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text="\(UserInfo.getUserName())"
        userEmail.text="\(UserInfo.getUserEmail())"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SettingsButton(sender: AnyObject) {
        
    }
    @IBAction func GetHelpButton(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.tk5.us")!)

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
