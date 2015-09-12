//
//  Person.swift
//  
//
//  Created by Kedan Li on 15/9/11.
//
//

import Foundation
import CoreData

class Person: NSManagedObject {

    @NSManaged var userId: NSNumber
    @NSManaged var userName: String
    @NSManaged var totalAmount: NSNumber
    @NSManaged var billList: NSSet

}
