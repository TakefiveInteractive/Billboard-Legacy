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
    
    func getBoardList()->[Board]?{
        var fetchRequest = NSFetchRequest(entityName: "Board")
        fetchRequest.includesPropertyValues = true //only fetch the managedObjectID
        var error: NSError?
        var fetchedBoard = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [Board]
        return fetchedBoard
    }
    
    
    
    func addBoard(info: [String: AnyObject]){
        Board(entity: boardObject, context: managedContext, billNum: NSNumber(int: info["billNum"] as! Int32), id: info["id"] as! String, isActive:  NSNumber(bool: info["isActive"] as! Bool), name: info["name"] as! String)
    }
    
    func saveContext(){
        //save context
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    
}
