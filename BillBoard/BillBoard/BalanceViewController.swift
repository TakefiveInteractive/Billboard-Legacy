//
//  BalanceViewController.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import MJRefresh
import Spring

class BalanceViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshTable")
        header.lastUpdatedTimeLabel.hidden = true
        header.setTitle("Pull down to refresh", forState: MJRefreshStateIdle)
        header.setTitle("Release to refresh", forState: MJRefreshStatePulling)
        header.setTitle("Loading ...", forState: MJRefreshStateRefreshing)
        self.tableView.header = header
        self.tableView.header.beginRefreshing()
    }
    
    func refreshTable() {
        delay(1, { () -> () in
            self.tableView.header.endRefreshing()
            self.tableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("balanceTableViewCell", forIndexPath: indexPath) as? BalanceTableViewCell
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "balanceTableViewCell")
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func imageForEmptyDataSet(scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "box_image")
    }
    
    func titleForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let textAttributes = [
            NSForegroundColorAttributeName: UIColor.lightGrayColor(),
            NSFontAttributeName: UIFont(name: "Helvetica", size: 17)!,
        ]
        return NSAttributedString(string: "No People", attributes: textAttributes)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let textAttributes = [
            NSForegroundColorAttributeName: UIColor.lightGrayColor(),
            NSFontAttributeName: UIFont(name: "Helvetica", size: 14)!,
        ]
        return NSAttributedString(string: "There is no people in your group, please add your group member on the left menu bar and manage your group there.", attributes: textAttributes)
    }
    
    func emptyDataSetShouldAllowScroll(scrollView: UIScrollView!) -> Bool {
        return true
    }
    

}