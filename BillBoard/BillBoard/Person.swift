//
//  Person.swift
//  BillBoard
//
//  Created by Kedan Li on 15/9/12.
//  Copyright (c) 2015年 Takefive Interactive. All rights reserved.
//

import Foundation
import CoreData

class Person: NSManagedObject {

    @NSManaged var totalAmount: NSNumber
    @NSManaged var userId: String
    @NSManaged var userName: String
    @NSManaged var billList: NSSet
    @NSManaged var group: Board
    

    
}
