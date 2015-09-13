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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalAmount.delegate = self
        theTitle.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let numOfPeople = 7
        let scrollView = UIScrollView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, openView.bounds.height))
        openView.addSubview(scrollView)
        let padding: CGFloat = 24
        scrollView.contentSize = CGSizeMake(padding * CGFloat(numOfPeople) + padding, openView.bounds.height)
        for i in 0..<numOfPeople {
            let avatar = UIImageView()
            avatar.frame = CGRectMake(CGFloat(i) * padding + padding, 16, 66, 66)
            avatar.layer.cornerRadius = avatar.bounds.width / 2
            scrollView.addSubview(avatar)
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if textField == totalAmount{
            if textField.text.length < 2{
                textField.text = "$ "
            }
            
            println(string)
            if textField.text.length >= 3 && Array(textField.text)[textField.text.length - 3] == "." && string != ""{
                return false
            }
            
            if (find(textField.text, "." as Character) != nil) && string == "."{
                return false
            }
                
        }
        return true
    }
    
    @IBAction func toggleDidPressed(sender: UIButton) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            if self.isToggled {
                self.lowerView.transform = CGAffineTransformMakeTranslation(0, 100)
            } else {
                self.lowerView.transform = CGAffineTransformIdentity
            }
        }) { (finished) -> Void in
            self.isToggled = !self.isToggled
        }
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
