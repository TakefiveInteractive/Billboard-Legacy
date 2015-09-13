//
//  FakeDataManager.swift
//  BillBoard
//
//  Created by Wang Yu on 9/13/15.
//  Copyright (c) 2015 Takefive Interactive. All rights reserved.
//

import UIKit

class FakeDataManager: NSObject {
   
    class func randomAvatar() -> UIImage {
        let randomNumber = arc4random_uniform(10)
        return UIImage(named: "Avator_\(randomNumber)")!
    }
    
    class func titleGenerate() -> String {
        let titles: [String] = [
            "Airbnb payments",
            "MHacks driving expense",
            "Lorem ipsum dolor sit amet",
            "Consectetur adipiscing elit",
            "Sed do eiusmod tempor",
            "Incididunt ut labore",
            "Et dolore magna aliqua",
            "Ut enim ad minim veniam"
        ]
        let randomNumber = Int(arc4random_uniform(7))
        return titles[randomNumber]
    }
}
