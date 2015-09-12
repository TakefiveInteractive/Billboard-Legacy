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
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let scrollViewHeight: CGFloat = UIScreen.mainScreen().bounds.height - searchBar.bounds.height - self.navigationController!.navigationBar.bounds.height
        scrollView.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, scrollViewHeight)
        let red = UIView(frame: CGRectMake(0, 0, scrollView.bounds.width, scrollView.bounds.height))
        red.backgroundColor = UIColor.redColor()
        let blue = UIView(frame: CGRectMake(scrollView.bounds.width, 0, scrollView.bounds.width, scrollView.bounds.height))
        blue.backgroundColor = UIColor.blueColor()
        scrollContentView.addSubview(red)
        scrollContentView.addSubview(blue)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetX = scrollView.contentOffset.x
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func menuButtonDidPressed(sender: UIButton) {
        revealController.showViewController(revealController.leftViewController)
    }
}
