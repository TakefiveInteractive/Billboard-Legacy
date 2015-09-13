//
//  LeftMenuViewController.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var GetHelpButton: UIButton!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
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

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupTableViewCell", forIndexPath: indexPath) as? UITableViewCell
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

}
