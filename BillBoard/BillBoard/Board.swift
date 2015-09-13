//
//  BillGroup.swift
//  BillBoard
//
//  Created by Kedan Li on 15/9/12.
//  Copyright (c) 2015年 Takefive Interactive. All rights reserved.
//

import Foundation
import CoreData

class Board: NSManagedObject {

    @NSManaged var billNum: NSNumber
    @NSManaged var id: String
    @NSManaged var isActive: NSNumber
    @NSManaged var name: String
    @NSManaged var grantBillList: NSSet
    @NSManaged var peopleList: NSSet

    convenience init(entity: NSEntityDescription, context: NSManagedObjectContext, billNum: NSNumber, id: String, isActive: NSNumber, name: String){
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.billNum = billNum
        self.id = id
        self.isActive = isActive
        self.name = name
    }
    
    func getPeopleList(){
        let info = [String: AnyObject]()
        
    }
    
    func addPerson(){
        
    }
    
}
