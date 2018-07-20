//
//  FireBaseConnector.swift
//  VideoCall
//
//  Created by Admin on 7/20/18.
//  Copyright © 2018 com.rene. All rights reserved.
//

import Foundation
import Firebase

typealias loginHandler = (User?, Error?) -> Void
typealias callingHandler = (User) -> Void
class FireBaseConnector{
    static let usersRef = Database.database().reference(withPath: "Users")
    
    fileprivate static func especificUserRef(userName: String) -> DatabaseReference{
        return Database.database().reference(withPath: "Users/\(userName)")
    }
    
    class func call(to calledUser: String, from: User, completion: @escaping (String) -> Void){
        var from = from
        let userReference = FireBaseConnector.especificUserRef(userName: calledUser)
        userReference.observeSingleEvent(of: .value, with: {snapshot in
            if var user = User(snapshot: snapshot){
                if(user.isInCall){
                    completion("that user is already in a call")
                }else{
                    user.isInCall = true
                    user.talkingTo = from.userName
                    completion("calling \(user)")
                    let myUserReference = FireBaseConnector.especificUserRef(userName: from.userName)
                    from.talkingTo = calledUser
                    from.isInCall = true
                    myUserReference.setValue(from.asAnyObject)
                    userReference.setValue(user.asAnyObject)
                }
            }else{
                completion("that user does not exist")
            }
        })
    }
    
    class func listenForCalls(user: User, completion: @escaping callingHandler){
        let userReference = FireBaseConnector.especificUserRef(userName: user.userName)
        userReference.observe(.value, with: {snapshot in
            if let user = User(snapshot: snapshot){
                completion(user)
            }
        })
    }
    
    class func logIn(userName: String, userPassword: String, completion: @escaping loginHandler){
        let userReference = FireBaseConnector.especificUserRef(userName: userName)
        userReference.observeSingleEvent(of: .value, with: {snapshot in
            let user = User(snapshot: snapshot)
            if let user = user {
                if(user.userPassword == userPassword){
                    completion(user,nil)
                }else{
                    completion(nil,LoginError())
                }
            }else {
                let newUser = User(userName: userName, userPassword: userPassword, isInCall: false)
                let userReference = FireBaseConnector.usersRef.child(userName)
                userReference.setValue(newUser.asAnyObject)
                completion(newUser,nil)
            }
        })
        
    }
}
