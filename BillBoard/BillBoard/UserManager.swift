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
import FBSDKShareKit

var UserInfo: UserManager = UserManager()

class UserManager: NSObject, FBSDKAppInviteDialogDelegate{
    
    let userDefault:NSUserDefaults


    func getUserName()->String{
        if let str = userDefault.objectForKey("userName") as? String{
            return str
        }else{
            return ""
        }
    }
    
    func getUserToken()->String{
        if let str = userDefault.objectForKey("userToken") as? String{
            return str
        }else{
            return ""
        }
    }
    
    func getUserEmail()->String{
        if let str = userDefault.objectForKey("userEmail") as? String{
            return str
        }else{
            return ""
        }
    }
    
    func getUserPortrait()->String{
        if let str = userDefault.objectForKey("userPortrait") as? String{
            return str
        }else{
            return ""
        }
    }

    override init() {
       userDefault = NSUserDefaults.standardUserDefaults()

    }
    
    lazy var isLogin: (() -> (Bool)) = {
        if self.userDefault.objectForKey("userID") != nil && self.userDefault.objectForKey("userID") as! String != "" && self.userDefault.objectForKey("userToken") != nil && self.userDefault.objectForKey("userToken") as! String != "" {
            return true
        }else{
            return false
        }
    }
    
    func facebookLogin(token: String, completion:(succ: Bool, error: String, result: [String: AnyObject]?) -> ()){
        
        if (FBSDKAccessToken.currentAccessToken() != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture.type(large)"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                //self.getFriends()
                //self.getMutualFriends()

            //println(((result["picture"]! as! [String: AnyObject])["data"]! as! [String: AnyObject])["url"]!)
                if error == nil{
                    self.userDefault.setObject(result["id"]!, forKey: "userID")
                    self.userDefault.setObject(result["name"]!, forKey: "userName")
                    self.userDefault.setObject(result["email"]!, forKey: "userEmail")
                    self.userDefault.setObject(((result["picture"]! as! [String: AnyObject])["data"]! as! [String: AnyObject])["url"]!, forKey: "userProfile")
                    self.userDefault.synchronize()
                    

                    
                    Alamofire.request(.POST, NSURL(string: ServerAddress + ServerVersion + "auth/login")!, parameters: ["fbToken": token]).responseJSON { (_, response, JSON, error) in
                        
                        if JSONHandler.jsonResponse(response, JSON: JSON, error: error){
                            
                            let result = SwiftyJSON.JSON(JSON!).dictionaryObject!
                            if result["accessToken"] != nil && result["accessToken"] as! String != "" {
                                self.userDefault.setObject(result["accessToken"], forKey: "userToken")
                                self.userDefault.synchronize()
                                completion(succ: true, error: "", result: nil)
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
    
    var token = NSMutableArray()
    
    func getFriends(){
    
        if (FBSDKAccessToken.currentAccessToken() != nil){
            FBSDKGraphRequest(graphPath: "/me/taggable_friends", parameters: nil).startWithCompletionHandler({ (connection, result, error) -> Void in
                if error == nil{
                    println(result)
                    for val in result["data"] as! [AnyObject]{
                        self.token.addObject(val["id"] as! String)
                    }
                }
            })
        }
        
    }
    
    func getMutualFriends(){
        if (FBSDKAccessToken.currentAccessToken() != nil){
            FBSDKGraphRequest(graphPath: "/me/friends", parameters: ["fields":"name,installed,first_name"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if error == nil{
                    println(result)
                }
            })
        }
        
    }
    

    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [NSObject : AnyObject]!) {
        
    }
    
    func appInviteDialog(appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: NSError!) {
        
    }
    
    func logout(){
        userDefault.setObject(nil, forKey: "userID")
        userDefault.setObject(nil, forKey: "userID")

        userDefault.synchronize()
    }
    

}
