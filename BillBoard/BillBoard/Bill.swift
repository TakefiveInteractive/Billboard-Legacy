//
//  Bill.swift
//  BillBoard
//
//  Created by Kedan Li on 15/9/12.
//  Copyright (c) 2015年 Takefive Interactive. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Bill: NSManagedObject {

    @NSManaged var amountList: AnyObject
    @NSManaged var photo: NSData
    @NSManaged var time: NSDate
    @NSManaged var title: String
    @NSManaged var paid: NSNumber
    @NSManaged var id: String
    @NSManaged var group: Board
    @NSManaged var owner: Person

    //

    
}
