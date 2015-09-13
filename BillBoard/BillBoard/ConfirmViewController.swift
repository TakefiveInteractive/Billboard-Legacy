//
//  ConfirmViewController.swift
//  BillBoard
//
//  Created by Kedan Li on 15/9/13.
//  Copyright (c) 2015年 Takefive Interactive. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var billOutStatement: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var billout: UIButton!
    
    let nameData = ["Yifei Teng","Ruth Cole","Angela Carter"]
    let amountData = ["$ 23.23","$ 396.00","$ 75.00"]

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameData.count
    }
    
    @IBAction func billOutConfirm(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "venmo://")!)
    }

    @IBAction func exit(sender: AnyObject) {
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: AnyObject? = tableView.dequeueReusableCellWithIdentifier("confirmcell")
        (cell as! UITableViewCell).selectionStyle = UITableViewCellSelectionStyle.None
        (cell as! ConfirmCell).peopleName.text = nameData[indexPath.item]
        (cell as! ConfirmCell).amount.text = amountData[indexPath.item]
        (cell as! ConfirmCell).peopleIcon.image = MockDataManager.randomAvatar()
        return cell as! UITableViewCell
    }
    
    override func viewDidLoad() {
        table.delegate = self
        table.dataSource = self
    }
    
}


class ConfirmCell: UITableViewCell {
    @IBOutlet weak var peopleIcon: UIImageView!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var peopleName: UILabel!
    
}
