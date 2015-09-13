//
//  AddBillViewController.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit

class AddBillViewController: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var totalAmount: UITextField!
    @IBOutlet weak var theTitle: UITextField!
    @IBOutlet weak var lowerView: UIView!
    @IBOutlet weak var openView: UIView!
    
    var totalAmountNum: Int = 0
    private var isToggled = false
    private var peopleBalance = [UILabel]()
    private var avatarList = [UIButton]()
    let numOfPeople = 7
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalAmount.delegate = self
        theTitle.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, openView.bounds.height))
        openView.addSubview(scrollView)
        let padding: CGFloat = 24
        let avatarWidth: CGFloat = 50
        scrollView.contentSize = CGSizeMake((padding + avatarWidth) * CGFloat(numOfPeople) + padding, openView.bounds.height)
        for i in 0..<numOfPeople {
            let avatar = UIButton()
            avatar.frame = CGRectMake(CGFloat(i) * padding + padding + CGFloat(i) * avatarWidth, 20, avatarWidth, avatarWidth)
            avatar.setImage(FakeDataManager.randomAvatar(), forState: UIControlState.Normal)
            avatar.layer.cornerRadius = avatar.bounds.width / 2
            avatar.tag = i
            avatar.addTarget(self, action: "avatarDidPressed:", forControlEvents: UIControlEvents.TouchUpInside)
            scrollView.addSubview(avatar)
            avatarList.append(avatar)
            
            let label = UILabel()
            label.frame = CGRectMake(avatar.frame.origin.x - 12, avatar.frame.origin.y + avatar.bounds.height + 8, padding + avatarWidth, 20)
            scrollView.addSubview(label)
            label.textAlignment = NSTextAlignment.Center
            label.font = UIFont.systemFontOfSize(12)
            label.text = "$ \(0.00)"
            peopleBalance.append(label)
        }
    }
    
    func avatarDidPressed(sender: UIButton) {
        if sender.alpha != 1 {
            sender.alpha = 1
        } else {
            sender.alpha = 0.3
        }
        updateBalance()
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == totalAmount{
            if textField.text.length < 2{
                textField.text = "$ "
            }
            if textField.text.length >= 3 && Array(textField.text)[textField.text.length - 3] == "." && string != ""{
                return false
            }
            
            if (find(textField.text, "." as Character) != nil) && string == "."{
                return false
            }
                
        }
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        updateBalance()
    }
    
    func updateBalance() {
        if totalAmount.text == "" || totalAmount == nil {
            totalAmount.becomeFirstResponder()
            totalAmount.text = "$ 0"
        }
        if let balance = totalAmount.text {
            let startIndex = advance(balance.startIndex, 2)
            let range = startIndex..<balance.endIndex
            let digits = balance.substringWithRange(range)
            let number = (digits as NSString).doubleValue
            
            var count = 0
            for i in 0..<numOfPeople {
                if avatarList[i].alpha == 1 {
                    count++
                }
            }
            for i in 0..<count {
                let meanNumber = number / Double(count)
                if avatarList[i].alpha == 1 {
                    peopleBalance[i].text = NSString(format: "$ %.02f", meanNumber) as String
                }
            }
        }
    }
    
    @IBAction func toggleDidPressed(sender: UIButton) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            if self.isToggled {
                self.lowerView.transform = CGAffineTransformMakeTranslation(0, self.openView.bounds.height)
            } else {
                self.lowerView.transform = CGAffineTransformIdentity
            }
        }) { (finished) -> Void in
            self.isToggled = !self.isToggled
        }
        updateBalance()
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        totalAmount.resignFirstResponder()
        theTitle.resignFirstResponder()
    }
    
    /*
    func getTotalAmountNum(){
        let str = totalAmount.text.substringFromIndex(totalAmount.text)
        for var index = 0; index < 3; index++ {
            if Array(totalAmount.text)[totalAmount.text.length - 1 - index] == "." {
                
                Array(totalAmount.text).removeAtIndex(totalAmount.text.length - 1 - index)
            }
                
        }
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
