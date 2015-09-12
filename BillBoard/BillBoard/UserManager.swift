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

    var userName = "Kedan"
    
    lazy var isLogin: (() -> (Bool)) = {
        if self.userDefault.objectForKey("userId") != nil && count(self.userDefault.objectForKey("userId") as! String) > 0 && self.userDefault.objectForKey("userToken") != nil && count(self.userDefault.objectForKey("userToken") as! String) > 0 {
            return true
        }else{
            return false
        }
    }
    
    func facebookLogin(token: String, completion:(succ: Bool, error: String, result: [String: AnyObject]?) -> ()){
        
        if (FBSDKAccessToken.currentAccessToken() != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: nil).startWithCompletionHandler({ (connection, result, error) -> Void in
                if error == nil{
                    self.userDefault.setObject(result["id"]!, forKey: "userID")
                    self.userDefault.setObject(result["name"]!, forKey: "userName")
                    self.userDefault.synchronize()
                    
                    Alamofire.request(.POST, NSURL(string: ServerAddress + ServerVersion + "auth/login")!, parameters: ["fbToken": token]).responseJSON { (_, response, JSON, error) in
                        
                        if JSONHandler.jsonResponse(response, JSON: JSON, error: error){
                            
                            let result = SwiftyJSON.JSON(JSON!).dictionaryObject!

                            if result["accessToken"] != nil && result["accessToken"]!.count > 0 {
                                self.userDefault.setObject(result["accessToken"], forKey: "userToken")
                                self.userDefault.synchronize()
                                completion(succ: true, error: result["error"] as! String, result: nil)
                            }else{
                                completion(succ: false, error: result["error"] as! String, result: nil)
                            }
                        }
                    }
                    
                }else{
                    //error
                    completion(succ: false, error: error.description, result: nil)
                }
            })
        }

    }
    
    func logout(){
        userDefault.setObject("", forKey: "userID")
        userDefault.synchronize()
    }
    

}
