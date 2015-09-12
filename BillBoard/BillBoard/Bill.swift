//
//  Bill.swift
//  
//
//  Created by Kedan Li on 15/9/11.
//
//

import Foundation
import CoreData

class Bill: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var time: NSDate
    @NSManaged var photo: NSData
    @NSManaged var amountList: AnyObject
    @NSManaged var owner: NSManagedObject
    @NSManaged var group: BillGroup

}
