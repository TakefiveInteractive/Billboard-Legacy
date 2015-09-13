//
//  MainViewController.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentControl.addTarget(self, action: "segmentControlDidChanged:", forControlEvents: UIControlEvents.ValueChanged)
        
        if !UserInfo.isLogin(){
            displayLoginViewController()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let scrollViewHeight: CGFloat = UIScreen.mainScreen().bounds.height - searchBar.bounds.height - self.navigationController!.navigationBar.bounds.height
//        scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width * 2, scrollViewHeight)
        contentView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width * 2, UIScreen.mainScreen().bounds.height)
        
//        let billViewController = storyboard?.instantiateViewControllerWithIdentifier("BillViewController") as! UIViewController
//        addChildViewController(billViewController as UIViewController)
//        billViewController.didMoveToParentViewController(self)
//        let billView = billViewController.view
//        scrollContentView.addSubview(billView)
    }

//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        if scrollView == self.scrollView {
//            let offsetX = scrollView.contentOffset.x
//            let page = Int( offsetX / (UIScreen.mainScreen().bounds.width/2) )
//            segmentControl.selectedSegmentIndex = page
//        }
//    }
    
    
    
    func segmentControlDidChanged(segmentControl: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
//            self.scrollView.setContentOffset(CGPointZero, animated: true)
        } else {
//            self.scrollView.setContentOffset(CGPointMake(UIScreen.mainScreen().bounds.width, 0), animated: true)
        }
    }

    @IBAction func menuButtonDidPressed(sender: UIBarButtonItem) {
        revealController.showViewController(revealController.leftViewController)
    }
}
