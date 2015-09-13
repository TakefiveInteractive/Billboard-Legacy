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
import Alamofire
import SwiftyJSON

var BoardInfo: BoardManager = BoardManager()

class BoardManager: NSObject {

    let userDefault:NSUserDefaults
    let managedContext: NSManagedObjectContext
    let boardObject: NSEntityDescription
    
    var boardList = [Board]()
    
    func getLastUpdatedTime() ->NSDate {
        return NSDate(timeIntervalSince1970: userDefault.doubleForKey("lastUpdatedTime"))
    }
    
    override init() {
        
        managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        boardObject = NSEntityDescription.entityForName("Board", inManagedObjectContext: managedContext)!
        userDefault = NSUserDefaults.standardUserDefaults()
        super.init()
        if !UserInfo.isLogin(){
            //remove all
        }else{
            //load from cache
            //get from internet
        }
    }
    
    func requestForBoardList() {
        let aManager = Manager.sharedInstance
        aManager.session.configuration.HTTPAdditionalHeaders = [
            "bb-token": UserInfo.getUserToken() ]
        
        Alamofire.request(.GET, NSURL(string: ServerAddress + ServerVersion + "board")!).responseJSON { (_, response, JSON, error) in
            println(JSON)
            if JSONHandler.jsonResponse(response, JSON: JSON, error: error){
                let result = (SwiftyJSON.JSON(JSON!).dictionaryObject!)["boards"] as! Array<[String: AnyObject]>
                for b in result {
                    self.addBoard(b)
                }
                self.saveContext()
            }
        }
        
    }
    
    func getBoardList() -> [Board]? {
        var fetchRequest = NSFetchRequest(entityName: "Board")
        fetchRequest.includesPropertyValues = true //only fetch the managedObjectID
        var error: NSError?
        var fetchedBoard = managedContext.executeFetchRequest(fetchRequest, error: &error) as? [Board]
        return fetchedBoard
    }
    
    func requestBillsInBoard(Board: String) -> [Bill] {
        let aManager = Manager.sharedInstance
        aManager.session.configuration.HTTPAdditionalHeaders = [
            "bb-token": UserInfo.getUserToken() ]
        
        
        
        return []
    }
    
    private func addBoard(info: [String: AnyObject]) {
        let board = Board(
            entity: boardObject,
            context: managedContext,
            billNum: NSNumber(integer: (info["bills"] as! NSArray).count),
            id: info["id"] as! String,
            isActive:  NSNumber(bool: info["isActive"] as! Bool),
            name: info["name"] as! String,
            billIds: (info["bills"] as! NSArray) as! [String]
        )
        boardList.append(board)
    }
    
    func saveContext() {
        //save context
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
    }
    
    
}
