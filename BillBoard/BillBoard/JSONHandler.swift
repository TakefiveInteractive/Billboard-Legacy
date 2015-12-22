//
//  JSONHandler.swift
//  BillBoard
//
//  Created by Kedan Li on 15/9/12.
//  Copyright (c) 2015年 Takefive Interactive. All rights reserved.
//

import Foundation
import SwiftyJSON

class JSONHandler: NSObject {
    static func jsonResponse (response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?)->Bool{
        print(response?.description)
        print(JSON)
        if response?.statusCode == 200{
            //succ
            if JSON != nil{
                let result = SwiftyJSON.JSON(JSON!).dictionaryObject!
                
                if SwiftyJSON.JSON(JSON!)["error"] == nil || SwiftyJSON.JSON(JSON!)["error"].string! == "" {
                    return true
             
                }else{
                    return false
                }
            }else{
                return true
            }
            
        }else{
            //error
            return false
        }
    }
}
