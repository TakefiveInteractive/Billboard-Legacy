//
//  MainViewController.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit
import Spring
import WYInteractiveTransitions

class MainViewController: UIViewController, UIScrollViewDelegate{

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var bill: UIView!
    @IBOutlet weak var balance: UIView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var billOut: UIView!
    @IBOutlet weak var billOutButton: UIButton!
    
    private var displayLeft = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.billOut.transform = CGAffineTransformMakeTranslation(-self.view.frame.width, 0)
        segmentControl.addTarget(self, action: "segmentControlDidChanged:", forControlEvents: UIControlEvents.ValueChanged)
        balance.alpha = 0
        
        let panGesture1 = UIPanGestureRecognizer(target: self, action: "dragged:")
        let panGesture2 = UIPanGestureRecognizer(target: self, action: "dragged:")
        bill.addGestureRecognizer(panGesture1)
        balance.addGestureRecognizer(panGesture2)
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.balance.transform = CGAffineTransformMakeTranslation(self.view.frame.width, 0)
            }) { (finish) -> Void in
                self.balance.alpha = 1
        }
        
        if !UserInfo.isLogin(){
            displayLoginViewController()
        }else{
            BoardInfo.requestForBoardList()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let scrollViewHeight: CGFloat = UIScreen.mainScreen().bounds.height - searchBar.bounds.height - self.navigationController!.navigationBar.bounds.height

    }
    
    func dragged(gesture: UIPanGestureRecognizer){
        
        let x = gesture.translationInView(self.view).x
        
        if displayLeft && x < 0 {
            bill.transform = CGAffineTransformMakeTranslation(x, 0)
            balance.transform = CGAffineTransformMakeTranslation(self.view.frame.width + x, 0)
            segmentControl.selectedSegmentIndex = 1
        } else if  !displayLeft && x > 0 {
            bill.transform = CGAffineTransformMakeTranslation(-self.view.frame.width + x, 0)
            balance.transform = CGAffineTransformMakeTranslation(x, 0)
            segmentControl.selectedSegmentIndex = 0
        }
        
        if (gesture.state == UIGestureRecognizerState.Cancelled || gesture.state == UIGestureRecognizerState.Failed || gesture.state == UIGestureRecognizerState.Ended) && (!displayLeft && x > 0 || displayLeft && x < 0){
            bill.userInteractionEnabled = false
            balance.userInteractionEnabled = false
            segmentControlDidChanged(segmentControl)
        }
    }
    
    func segmentControlDidChanged(segmentControl: UISegmentedControl) {
        if displayLeft {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.bill.transform = CGAffineTransformMakeTranslation(-self.view.frame.width, 0)
                self.balance.transform = CGAffineTransformMakeTranslation(0, 0)
                self.billOut.transform = CGAffineTransformMakeTranslation(0, 0)
                self.addButton.transform = CGAffineTransformMakeTranslation(100, 0)
                }, completion: { (finish) -> Void in
                    self.displayLeft = false
                    self.bill.userInteractionEnabled = true
                    self.balance.userInteractionEnabled = true
            })
        } else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                self.bill.transform = CGAffineTransformMakeTranslation(0, 0)
                self.balance.transform = CGAffineTransformMakeTranslation(self.view.frame.width, 0)
                self.billOut.transform = CGAffineTransformMakeTranslation(-self.view.frame.width, 0)
                self.addButton.transform = CGAffineTransformMakeTranslation(0, 0)
                }, completion: { (finish) -> Void in
                    self.displayLeft = true
                    self.bill.userInteractionEnabled = true
                    self.balance.userInteractionEnabled = true
                    //display count
            })
        }
    }
    
    @IBAction func menuButtonDidPressed(sender: UIBarButtonItem) {
        revealController.showViewController(revealController.leftViewController)
    }
    @IBAction func billOutConfirm(sender: AnyObject) {
        displayConfirmBillViewController()
    }
}
