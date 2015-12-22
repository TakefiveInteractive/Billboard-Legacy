//
//  LeftMenuViewController.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit
import Spring

class LeftMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var GetHelpButton: UIButton!
    @IBOutlet weak var logout: UIButton!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var icon: DesignableImageView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BoardInfo.boardList.count + 2
    }
    
    @IBAction func logout(sender: AnyObject) {
        UserInfo.logout()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AnyObject? = tableView.dequeueReusableCellWithIdentifier("boardcell")
        (cell as! UITableViewCell).selectionStyle = UITableViewCellSelectionStyle.None
        if indexPath.item == 1{
            (cell as! BoardCell).billName.alpha = 0
            (cell as! BoardCell).peopleList.alpha = 0
            (cell as! BoardCell).amount.alpha = 0//"$ \(BoardInfo.boardList[indexPath.item].peopleList)"
            (cell as! BoardCell).peopleNum.alpha = 0
            (cell as! BoardCell).peopleIcon.alpha = 0
            (cell as! BoardCell).littlePeopleIcon.alpha = 0
            (cell as! BoardCell).writeIcon.alpha = 1
        }else{
            (cell as! BoardCell).billName.text = "Kedan Li"//BoardInfo.boardList[indexPath.item].name
            (cell as! BoardCell).peopleList.text = "Ted, Kedan, Yu Wang"
            (cell as! BoardCell).amount.text = "$ 234.49"//"$ \(BoardInfo.boardList[indexPath.item].peopleList)"
            (cell as! BoardCell).peopleNum.text = "3"
            (cell as! BoardCell).peopleIcon.image = MockDataManager.groupFake()
        }
        return cell as! UITableViewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text="\(UserInfo.getUserName())"
        userEmail.text="\(UserInfo.getUserEmail())"
        
        table.dataSource = self
        table.delegate = self
        changeIcon()

        // Do any additional setup after loading the view.
    }
    
    func changeIcon(){
        if "" != UserInfo.getUserPortrait(){
            icon.image = UIImage(data: NSData(contentsOfURL: NSURL(string: UserInfo.getUserPortrait())!)!)
        }
    }

    override func viewDidAppear(animated: Bool) {
        table.contentInset = UIEdgeInsetsZero
        icon.layer.cornerRadius = icon.frame.width / 2
        icon.clipsToBounds = true
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
}


class BoardCell: UITableViewCell {
    @IBOutlet weak var peopleIcon: UIImageView!
    @IBOutlet weak var writeIcon: UIImageView!
    @IBOutlet weak var peopleList: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var peopleNum: UILabel!
    @IBOutlet weak var billName: UILabel!
    @IBOutlet weak var littlePeopleIcon: UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clearColor()

    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
}
