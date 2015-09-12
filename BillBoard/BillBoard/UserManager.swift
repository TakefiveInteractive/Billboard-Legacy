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
    
    lazy var isLogin: (() -> (Bool)) = {
        if self.userDefault.objectForKey("userID") != nil && count(self.userDefault.objectForKey("userID") as! String) > 0 {
            return true
        }else{
            return false
        }
    }
    
    func login(userID: String){
        
    }

}
