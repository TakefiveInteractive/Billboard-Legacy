//
//  FakeDataManager.swift
//  BillBoard
//
//  Created by Wang Yu on 9/13/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit

class DataManager: NSObject {
   
    class func groupFake()->UIImage{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(300, 300), false, 0)
        randomAvatar().drawInRect(CGRectMake(0, 100, 180, 180))
        randomAvatar().drawInRect(CGRectMake(120, 100, 180, 180))
        randomAvatar().drawInRect(CGRectMake(70, 0, 180, 180))
        var img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    class func randomAvatar() -> UIImage {
        let randomNumber = arc4random_uniform(100)
        return UIImage(named: "Avator_\(randomNumber)")!
    }
    
    class func titleGenerate() -> String {
        let titles: [String] = [
            "MHacks",
            "HackIllinois",
            "Road Trip",
            "Walmart",
            "Dinner at Redlob",
            "Airbnb",
            "Rental",
            "Sakanaya",
            "App Store",
            "Utility Fee",
            "Parking",
            "Food"
        ]
        let cnt = UInt32(titles.count)
        let randomNumber = Int(arc4random_uniform(cnt))
        return titles[randomNumber]
    }
    
    class func randomDecimal() -> Double {
        let random = Double(randomBetweenNumbers(-1000.22, secondNum: 1000.22))
        let formatter = NSNumberFormatter()
        return Double(random)
    }
    
    class func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }

    class func randomName() -> String {
        let names = [
            "Ralph Hamilton","Eugene Hudson","William Powell","Stephen Bradley","Terry Duncan","Joseph Castillo","Roy Lawrence","Jean Morgan","Ruth Cole","Angela Carter"
        ]
        let cnt = UInt32(names.count)
        let randomNumber = Int(arc4random_uniform(cnt))
        return names[randomNumber]
    }
}


