//
//  UserManager.swift
//  BillBoard
//
//  Created by Kedan Li on 15/9/11.
//  Copyright (c) 2015年 Takefive Interactive. All rights reserved.
//

import Foundation

var UserInfo: UserManager = UserManager()

class UserManager: NSObject {

    let userDefault = NSUserDefaults.standardUserDefaults()

    var userName = ""
    
    lazy var isLogin: (() -> (Bool)) = {
        if self.userDefault.objectForKey("userID") != nil && count(self.userDefault.objectForKey("userID") as! String) > 0 {
            return true
        }else{
            return false
        }
    }
    
    func login(userID: String){
        userDefault.setObject(userID, forKey: "userID")
        userDefault.synchronize()
    }
    
    func logout(){
        userDefault.setObject("", forKey: "userID")
        userDefault.synchronize()
    }
    

}
