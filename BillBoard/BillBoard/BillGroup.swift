//
//  BillGroup.swift
//  
//
//  Created by Kedan Li on 15/9/11.
//
//

import Foundation
import CoreData

class BillGroup: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var name: String
    @NSManaged var peopleNum: NSNumber
    @NSManaged var billNum: NSNumber
    @NSManaged var isActive: NSNumber
    @NSManaged var peopleList: NSSet
    @NSManaged var grantBillList: NSSet

}
