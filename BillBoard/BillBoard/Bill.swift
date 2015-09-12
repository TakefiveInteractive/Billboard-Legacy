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
    convenience init(entity: NSEntityDescription, context: NSManagedObjectContext, title: String, time: NSDate, amountList:[Person: Double], group: Board, owner: Person, photo: NSData, paid: NSNumber){
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        self.title = title
        self.time = time
        self.photo = photo
        self.paid = paid
        self.amountList = amountList
    }
    
    // get a person's amount of money
    func getPersonAmount(person: Person)->Double{
        if let value = (amountList as! [Person: Double])[person]{
            return value
        }else{
            return 0
        }
    }
    
    func getPhoto()->UIImage?{
        if photo.length == 0{
            return UIImage(data: photo)
        }else{
            return nil
        }
    }
    
}
