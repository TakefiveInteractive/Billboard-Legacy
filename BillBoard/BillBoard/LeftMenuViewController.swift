//
//  LeftMenuViewController.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var SettingsButton: UIButton!
    @IBOutlet weak var GetHelpButton: UIButton!
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    
    @IBOutlet weak var table: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BoardInfo.boardList.count + 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: AnyObject? = tableView.dequeueReusableCellWithIdentifier("boardcell")
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
            (cell as! BoardCell).peopleList.text = "Ted,Kedan,Wy"
            (cell as! BoardCell).amount.text = "$ 63.00"//"$ \(BoardInfo.boardList[indexPath.item].peopleList)"
            (cell as! BoardCell).peopleNum.text = "3"
            (cell as! BoardCell).peopleIcon.image = FakeDataManager.groupFake()
        }
        return cell as! UITableViewCell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.text="\(UserInfo.getUserName())"
        userEmail.text="\(UserInfo.getUserEmail())"
        
        table.dataSource = self
        table.delegate = self
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        table.contentInset = UIEdgeInsetsZero
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
        println(indexPath)
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

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.clearColor()
    }
    
}
