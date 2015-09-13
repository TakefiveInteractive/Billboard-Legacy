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
    
    let data = [""]
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
    }
    
    override func viewDidLoad() {
        
    }
    
}


class ConfirmCell: UITableViewCell {
    @IBOutlet weak var peopleIcon: UIImageView!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var peopleNum: UILabel!
    
}
