//
//  User.swift
//  VideoCall
//
//  Created by Admin on 7/20/18.
//  Copyright © 2018 com.rene. All rights reserved.
//

import Foundation
import Firebase

struct Users {
    let users: [User]
    
//    init?(snapshot: DataSnapshot){
//        guard let rawUsers = snapshot.value as? [AnyObject] else {return nil}
//        
//    }
    
}

struct User {
    let userName: String
    let userPassword: String
    var isInCall: Bool
    var talkingTo: String
    
    var asAnyObject: AnyObject{
        return ["userName": userName,
                "userPassword": userPassword,
                "isInCall": isInCall,
                "talkingTo": talkingTo] as AnyObject
    }
    
    init(userName: String,
         userPassword: String,
         isInCall: Bool){
        self.userName = userName
        self.userPassword = userPassword
        self.isInCall = isInCall
        self.talkingTo = ""
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: AnyObject],
            let userName = value["userName"] as? String,
            let userPassword = value["userPassword"] as? String,
            let isInCall = value["isInCall"] as? Bool,
            let talkingTo = value["talkingTo"] as? String else {
                return nil
        }
        self.userName = userName
        self.userPassword = userPassword
        self.isInCall = isInCall
        self.talkingTo = talkingTo
    }
}
