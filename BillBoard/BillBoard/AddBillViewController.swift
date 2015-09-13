//
//  AddBillViewController.swift
//  BillBoard
//
//  Created by Wang Yu on 9/12/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit
import MobileCoreServices

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
    
    var imagePicker: UIImagePickerController? = UIImagePickerController()
    var popOverChoice: UIPopoverController? = nil
    var shouldSaveToAlbum: Bool = false
    @IBOutlet var imagePickerView: UIView!
    @IBOutlet var imageView: UIImageView!
    
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
            avatar.setImage(MockDataManager.randomAvatar(), forState: UIControlState.Normal)
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
            label.textColor = UIColor(hex: "E24E35")
            label.text = "$ 0.00"
            peopleBalance.append(label)
        }
    }
    
    func avatarDidPressed(sender: UIButton) {
        if sender.alpha != 1 {
            sender.alpha = 1
            peopleBalance[sender.tag].alpha = 1
        } else {
            sender.alpha = 0.2
            peopleBalance[sender.tag].text = "$ 0.00"
            peopleBalance[sender.tag].alpha = 0.2
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
            for i in 0..<numOfPeople {
                let meanNumber = number / Double(count)
                if avatarList[i].alpha == 1 {
                    peopleBalance[i].text = NSString(format: "$ %.02f", meanNumber) as String
                }
            }
        }
    }
    
    @IBAction func toggleDidPressed(sender: UIButton) {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            if !self.isToggled {
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
    
    @IBAction func completeButtonDidPressed(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func cameraButtonDidPressed(sender: UIButton) {
        invokePopOver()
    }
    
    // set up to invoke camera
    func openCamera() {
        
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
            imagePicker!.allowsEditing = false
            imagePicker!.sourceType = UIImagePickerControllerSourceType.Camera
            imagePicker!.mediaTypes = [kUTTypeImage]
            imagePicker!.cameraCaptureMode = .Photo
            
            shouldSaveToAlbum = true
            popOutImagePickerView()
        }
            // if there's no camera detected
        else {
            let alertVC = UIAlertController(title: "No Camera", message: "Camera Not Detected", preferredStyle: .Alert)
            let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
            alertVC.addAction(okAction)
            presentViewController(alertVC, animated: true, completion: nil)
        }
    }
    
    // set up to invoke gallary
    func openGallery() {
        
        imagePicker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            
            shouldSaveToAlbum = false
            popOutImagePickerView()
            // self.presentViewController(imagePicker!, animated: true, completion: nil)
        }
        else {
            //error handling
            popOverChoice = UIPopoverController(contentViewController: imagePicker!)
            popOverChoice!.presentPopoverFromRect(imageView.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    // handle the taken photo
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!) {
        returnFromImagePickerView()
        if shouldSaveToAlbum {
            // save image to album
            UIImageWriteToSavedPhotosAlbum(info[UIImagePickerControllerOriginalImage] as! UIImage, nil, nil, nil)
        }
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        returnFromImagePickerView()
    }
    
    
    func invokePopOver() {
        
        var alert:UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        var cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.openCamera()
        }
        var gallaryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            self.openGallery()
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
        }
        
        // Add the actions
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        
        // Present the controller
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else {
            popOverChoice = UIPopoverController(contentViewController: alert)
            popOverChoice!.presentPopoverFromRect(imageView.frame,inView: self.view,
                permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
        }
    }
    
    func popOutImagePickerView() {
        self.presentViewController(self.imagePicker!, animated: true, completion: nil)
    }
    
    func returnFromImagePickerView() {
        
    }
}
