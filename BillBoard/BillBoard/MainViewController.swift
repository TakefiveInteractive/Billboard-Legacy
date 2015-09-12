//
//  MainViewController.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var menuBarButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var scrollContentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        segmentControl.addTarget(self, action: "segmentControlDidChanged:", forControlEvents: UIControlEvents.ValueChanged)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let scrollViewHeight: CGFloat = UIScreen.mainScreen().bounds.height - searchBar.bounds.height - self.navigationController!.navigationBar.bounds.height
        scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, scrollViewHeight)

        // Do any additional setup after loading the view.
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offsetX = scrollView.contentOffset.x
        let page = Int( offsetX / (UIScreen.mainScreen().bounds.width/2) )
        segmentControl.selectedSegmentIndex = page
    }
    
    func segmentControlDidChanged(segmentControl: UISegmentedControl) {
        if segmentControl.selectedSegmentIndex == 0 {
            self.scrollView.setContentOffset(CGPointZero, animated: true)
        } else {
            self.scrollView.setContentOffset(CGPointMake(UIScreen.mainScreen().bounds.width, 0), animated: true)
        }
    }

    @IBAction func menuButtonDidPressed(sender: UIButton) {
        revealController.showViewController(revealController.leftViewController)
    }
}
