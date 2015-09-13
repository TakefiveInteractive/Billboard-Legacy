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
    
    var displayLeft = true
    
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
        var panGesture = UIPanGestureRecognizer(target: self, action: "dragged:")
        contentView.addGestureRecognizer(panGesture)
    }
    
    func dragged(gesture: UIPanGestureRecognizer){
        
        var x = gesture.translationInView(self.view).x
        
        if displayLeft && x < 0{
            contentView.transform = CGAffineTransformMakeTranslation(x, 0)
        }else if  !displayLeft && x > 0{
            contentView.transform = CGAffineTransformMakeTranslation(-self.view.frame.width + x, 0)
        }
        
        if (gesture.state == UIGestureRecognizerState.Cancelled || gesture.state == UIGestureRecognizerState.Failed || gesture.state == UIGestureRecognizerState.Ended) && (!displayLeft && x > 0 || displayLeft && x < 0){
            contentView.userInteractionEnabled = false
            if displayLeft{
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.contentView.transform = CGAffineTransformMakeTranslation(-self.view.frame.width, 0)
                }, completion: { (finish) -> Void in
                        self.displayLeft = false
                        self.contentView.userInteractionEnabled = true
                })
            }else{
                UIView.animateWithDuration(0.3, animations: { () -> Void in
                    self.contentView.transform = CGAffineTransformMakeTranslation(0, 0)
                    }, completion: { (finish) -> Void in
                        self.displayLeft = true
                        self.contentView.userInteractionEnabled = true
                })
            }
        }
    }
    
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
