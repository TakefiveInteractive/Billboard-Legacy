//
//  BoardManager.swift
//  BillBoard
//
//  Created by Kedan Li on 15/9/12.
//  Copyright (c) 2015年 Takefive Interactive. All rights reserved.
//

import Foundation
import CoreData
import UIKit

var BoardInfo: BoardManager = BoardManager()

class BoardManager: NSObject {

    let managedContext: NSManagedObjectContext
    let boardObject: NSEntityDescription
    
    override init() {
        
        managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        boardObject = NSEntityDescription.entityForName("Board", inManagedObjectContext: managedContext)!
        super.init()
        if !UserInfo.isLogin(){
            //remove all
        }else{
            
        }
    }
    
    func saveContext(){
        //save context
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    
}
