//
//  UserManager.swift
//  BillBoard
//
//  Created by Kedan Li on 15/9/11.
//  Copyright (c) 2015年 Takefive Interactive. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import FBSDKCoreKit


var UserInfo: UserManager = UserManager()

class UserManager: NSObject {
    
    let userDefault = NSUserDefaults.standardUserDefaults()

    var userName = ""
    
    lazy var isLogin: (() -> (Bool)) = {
        if self.userDefault.objectForKey("userId") != nil && count(self.userDefault.objectForKey("userId") as! String) > 0 && self.userDefault.objectForKey("userToken") != nil && count(self.userDefault.objectForKey("userToken") as! String) > 0 {
            return true
        }else{
            return false
        }
    }
    
    func jsonResponse (response: NSHTTPURLResponse?, JSON: AnyObject?, error: NSError?, completion:(error: String, result: [String: AnyObject]?) -> ()){
        if error == nil{
            //succ
            if JSON != nil{
                let result = SwiftyJSON.JSON(JSON!).dictionaryObject!
                if result["accessToken"] != nil && result["accessToken"]!.count > 0{
                    userDefault.setObject(result["accessToken"], forKey: "userToken")
                    userDefault.synchronize()
                }
                completion(error: SwiftyJSON.JSON(JSON!)["error"].string!, result: SwiftyJSON.JSON(JSON!).dictionaryObject)
            }else{
                completion(error: "", result: nil)
            }
            
        }else{
            //error
            if JSON != nil && SwiftyJSON.JSON(JSON!)["error"] != nil{
                completion(error: SwiftyJSON.JSON(JSON!)["error"].string!, result: nil)
            }else{
                completion(error: error!.description, result: nil)
            }
        }
    }
    
    func facebookLogin(token: String, completion:(error: String, result: [String: AnyObject]?) -> ()){
        
        if (FBSDKAccessToken.currentAccessToken() != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler({ (connection, result, error) -> Void in
                if error == nil{
                    self.userDefault.setObject(result["id"]!, forKey: "userID")
                    self.userDefault.setObject(result["name"]!, forKey: "userName")
                    self.userDefault.synchronize()
                    
                    Alamofire.request(.POST, NSURL(string: ServerAddress + ServerVersion + "auth/login")!, parameters: ["fbToken": token]).responseJSON { (_, response, JSON, error) in
                        self.jsonResponse(response, JSON: JSON, error: error, completion: completion)
                    }
                    
                }else{
                    //error
                    completion(error: error.description, result: nil)
                }
            })
        }

    }
    
    func logout(){
        userDefault.setObject("", forKey: "userID")
        userDefault.synchronize()
    }
    

}
