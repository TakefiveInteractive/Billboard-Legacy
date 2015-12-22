//
//  BillViewController.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import MJRefresh
import Spring

class BillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    @IBOutlet weak var tableView: UITableView!
    var bills = [Bill]()
    var billNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: "refreshTable")
        header.lastUpdatedTimeLabel!.hidden = true
        header.setTitle("Pull down to refresh", forState: MJRefreshStateIdle)
        header.setTitle("Release to refresh", forState: MJRefreshStatePulling)
        header.setTitle("Loading ...", forState: MJRefreshStateRefreshing)
        self.tableView.header = header
        self.tableView.header.beginRefreshing()
    }
    
    func refreshTable() {
        delay(1, { () -> () in
            self.tableView.header.endRefreshing()
            self.billNumber += random() % 5
            self.tableView.reloadData()
        })
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billNumber
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("billTableViewCell", forIndexPath: indexPath) as? BillTableViewCell
        return cell!
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
        return NSAttributedString(string: "No Transection", attributes: textAttributes)
    }
    
    func descriptionForEmptyDataSet(scrollView: UIScrollView!) -> NSAttributedString! {
        let textAttributes = [
            NSForegroundColorAttributeName: UIColor.lightGrayColor(),
            NSFontAttributeName: UIFont(name: "Helvetica", size: 14)!,
        ]
        return NSAttributedString(string: "There is no record around, please press the add button below to start your first bill.", attributes: textAttributes)
    }
    
    func emptyDataSetShouldAllowScroll(scrollView: UIScrollView!) -> Bool {
        return true
    }
    
}
